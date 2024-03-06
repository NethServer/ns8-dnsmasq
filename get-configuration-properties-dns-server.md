# Untitled object in Configuration of dnsmasq Schema

```txt
http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dns-server
```

Defines DNS server configuration

| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                        |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :-------------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [get-configuration.json\*](dnsmasq/get-configuration.json "open original schema") |

## dns-server Type

`object` ([Details](get-configuration-properties-dns-server.md))

# dns-server Properties

| Property                              | Type      | Required | Nullable       | Defined by                                                                                                                                                                                                          |
| :------------------------------------ | :-------- | :------- | :------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [enabled](#enabled)                   | `boolean` | Required | cannot be null | [Configuration of dnsmasq](get-configuration-properties-dns-server-properties-enabled.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dns-server/properties/enabled")                   |
| [primary-server](#primary-server)     | Merged    | Required | cannot be null | [Configuration of dnsmasq](get-configuration-properties-dns-server-properties-primary-server.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dns-server/properties/primary-server")     |
| [secondary-server](#secondary-server) | Merged    | Required | cannot be null | [Configuration of dnsmasq](get-configuration-properties-dns-server-properties-secondary-server.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dns-server/properties/secondary-server") |

## enabled

Enable DNS server

`enabled`

*   is required

*   Type: `boolean`

*   cannot be null

*   defined in: [Configuration of dnsmasq](get-configuration-properties-dns-server-properties-enabled.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dns-server/properties/enabled")

### enabled Type

`boolean`

## primary-server

Primary DNS server

`primary-server`

*   is required

*   Type: `string` ([Details](get-configuration-properties-dns-server-properties-primary-server.md))

*   cannot be null

*   defined in: [Configuration of dnsmasq](get-configuration-properties-dns-server-properties-primary-server.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dns-server/properties/primary-server")

### primary-server Type

`string` ([Details](get-configuration-properties-dns-server-properties-primary-server.md))

one (and only one) of

*   [Untitled undefined type in Configuration of dnsmasq](get-configuration-properties-dns-server-properties-primary-server-oneof-0.md "check type definition")

*   [Untitled undefined type in Configuration of dnsmasq](get-configuration-properties-dns-server-properties-primary-server-oneof-1.md "check type definition")

*   [Untitled undefined type in Configuration of dnsmasq](get-configuration-properties-dns-server-properties-primary-server-oneof-2.md "check type definition")

## secondary-server

Secondary DNS server

`secondary-server`

*   is required

*   Type: `string` ([Details](get-configuration-properties-dns-server-properties-secondary-server.md))

*   cannot be null

*   defined in: [Configuration of dnsmasq](get-configuration-properties-dns-server-properties-secondary-server.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dns-server/properties/secondary-server")

### secondary-server Type

`string` ([Details](get-configuration-properties-dns-server-properties-secondary-server.md))

one (and only one) of

*   [Untitled undefined type in Configuration of dnsmasq](get-configuration-properties-dns-server-properties-secondary-server-oneof-0.md "check type definition")

*   [Untitled undefined type in Configuration of dnsmasq](get-configuration-properties-dns-server-properties-secondary-server-oneof-1.md "check type definition")

*   [Untitled undefined type in Configuration of dnsmasq](get-configuration-properties-dns-server-properties-secondary-server-oneof-2.md "check type definition")
