import ipaddress
from robot.api.deco import keyword

@keyword('GetDhcpRange')
def get_dhcp_range(addr):
    net = ipaddress.ip_interface(addr).network

    hosts = list(net.hosts())
    if not hosts:
        raise ValueError(f'No usable hosts in network {net}')

    return str(hosts[0]), str(hosts[-1])

