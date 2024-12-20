#!/usr/bin/env python3

#
# Copyright (C) 2024 Nethesis S.r.l.
# SPDX-License-Identifier: GPL-3.0-or-later
#

import os
import agent
import ipaddress
import json
import subprocess
import socket


def __filter_interface(interface):
    """
    Filter the interfaces that are not useful for the configuration.
    """
    # filter by name
    interface_name = interface["ifname"]
    if interface_name.startswith("lo"):
        return False
    if interface_name.startswith("wg"):
        return False

    # filter by configuration status
    if "addr_info" not in interface or interface["addr_info"] == []:
        return False

    # return True if the interface is not filtered
    return True


def __format_interface(interface):
    """
    Format the interface that can be used internally for responses.
    """
    interface_data = {
        "name": interface["ifname"],
        "addresses": [],
        "start": "",
        "end": "",
        "gateway": ""
    }
    gateway = subprocess.run(["ip", "-4", "-j", "route", "show", "dev", interface["ifname"], "default"], check=True,
                             capture_output=True, text=True).stdout
    gateway = json.loads(gateway)
    if len(gateway) > 0:
        gateway = gateway[0]['gateway']
    else:
        gateway = None
    for address in interface["addr_info"]:
        if address["family"] == "inet":
            network = ipaddress.IPv4Network(address["local"] + "/" + str(address["prefixlen"]), strict=False)
            interface_data["addresses"].append({
                "address": ipaddress.IPv4Address(address["local"]),
                "network": network
            })
            # last address wins the start and end fields
            interface_data["start"] = network.network_address + 1
            interface_data["end"] = network.network_address + network.num_addresses - 2
            if gateway is not None and ipaddress.IPv4Address(gateway) in network:
                interface_data["gateway"] = gateway

    return interface_data


def list_interfaces():
    """
    Returns a list of interfaces with their available addresses.
    """
    subprocess_result = subprocess.run(["ip", "-4", "-j", "addr"], check=True, capture_output=True)
    interfaces = [__format_interface(interface) for interface in json.loads(subprocess_result.stdout) if __filter_interface(interface)]
    if os.environ.get('DNSMASQ_RELAXED_INTERFACE_VALIDATION', "0") == "0":
        interfaces = [interface for interface in interfaces if interface['addresses'][0]['network'].is_private]
    return interfaces

def __is_port_bound(port, protocol, ip='127.0.0.1'):
    """
    Check if a port is already bound for a given protocol (TCP/UDP) on a specific IP address.
    """
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM if protocol == 'tcp' else socket.SOCK_DGRAM)
    try:
        s.bind((ip, port))
        s.close()
        return False
    except OSError:
        return True

def are_ports_53_bound(ip='127.0.0.1'):
    """
    Check if both TCP and UDP ports 53 are bound on a specific IP address.
    """
    return __is_port_bound(53, 'tcp', ip) or __is_port_bound(53, 'udp', ip)

def get_local_samba_dcs():
    """
    Lookup Samba modules installed on the local node. Returns an array of
    Samba module IDs that were installed on the local node. Typically the
    array has 1 element at most.
    """
    rdb = agent.redis_connect(use_replica=True)
    local_samba_dcs = []
    for module_id, node_id in rdb.hgetall("cluster/module_node").items():
        if node_id != os.environ["NODE_ID"]:
            continue
        if module_id.startswith('samba'):
            local_samba_dcs.append(module_id)
    return local_samba_dcs
