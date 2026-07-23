# Configuration of dnsmasq Schema

```txt
http://schema.nethserver.org/dnsmasq/get-configuration.json
```

Retrieve the configuration of dnsmasq.

| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                      |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :------------------------------------------------------------------------------ |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [get-configuration.json](dnsmasq/get-configuration.json "open original schema") |

## Configuration of dnsmasq Type

`object` ([Configuration of dnsmasq](get-configuration.md))

# Configuration of dnsmasq Properties

| Property                            | Type      | Required | Nullable       | Defined by                                                                                                                                                          |
| :---------------------------------- | :-------- | :------- | :------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [interface](#interface)             | `string`  | Required | cannot be null | [Configuration of dnsmasq](get-configuration-properties-interface.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/interface")           |
| [dhcp-server](#dhcp-server)         | `object`  | Required | cannot be null | [Configuration of dnsmasq](get-configuration-properties-dhcp-server.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dhcp-server")       |
| [dns-server](#dns-server)           | `object`  | Required | cannot be null | [Configuration of dnsmasq](get-configuration-properties-dns-server.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dns-server")         |
| [is\_dns\_enabled](#is_dns_enabled) | `boolean` | Required | cannot be null | [Configuration of dnsmasq](get-configuration-properties-is_dns_enabled.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/is_dns_enabled") |
| [is\_dns\_bound](#is_dns_bound)     | `boolean` | Required | cannot be null | [Configuration of dnsmasq](get-configuration-properties-is_dns_bound.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/is_dns_bound")     |

## interface

Network interface, a list is provided by the 'get-available-interfaces' action

`interface`

* is required

* Type: `string`

* cannot be null

* defined in: [Configuration of dnsmasq](get-configuration-properties-interface.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/interface")

### interface Type

`string`

## dhcp-server

Defines DHCP server configuration

`dhcp-server`

* is required

* Type: `object` ([Details](get-configuration-properties-dhcp-server.md))

* cannot be null

* defined in: [Configuration of dnsmasq](get-configuration-properties-dhcp-server.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dhcp-server")

### dhcp-server Type

`object` ([Details](get-configuration-properties-dhcp-server.md))

## dns-server

Defines DNS server configuration

`dns-server`

* is required

* Type: `object` ([Details](get-configuration-properties-dns-server.md))

* cannot be null

* defined in: [Configuration of dnsmasq](get-configuration-properties-dns-server.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dns-server")

### dns-server Type

`object` ([Details](get-configuration-properties-dns-server.md))

## is\_dns\_enabled

True if dnsmasq is configured

`is_dns_enabled`

* is required

* Type: `boolean`

* cannot be null

* defined in: [Configuration of dnsmasq](get-configuration-properties-is_dns_enabled.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/is_dns_enabled")

### is\_dns\_enabled Type

`boolean`

## is\_dns\_bound

True if DNS servers are bound to the interface

`is_dns_bound`

* is required

* Type: `boolean`

* cannot be null

* defined in: [Configuration of dnsmasq](get-configuration-properties-is_dns_bound.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/is_dns_bound")

### is\_dns\_bound Type

`boolean`
