# Untitled object in Configuration of dnsmasq Schema

```txt
http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dhcp-server
```

Defines DHCP server configuration

| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                        |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :-------------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [get-configuration.json\*](dnsmasq/get-configuration.json "open original schema") |

## dhcp-server Type

`object` ([Details](get-configuration-properties-dhcp-server.md))

# dhcp-server Properties

| Property            | Type      | Required | Nullable       | Defined by                                                                                                                                                                                          |
| :------------------ | :-------- | :------- | :------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [enabled](#enabled) | `boolean` | Required | cannot be null | [Configuration of dnsmasq](get-configuration-properties-dhcp-server-properties-enabled.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dhcp-server/properties/enabled") |
| [start](#start)     | Merged    | Required | cannot be null | [Configuration of dnsmasq](get-configuration-properties-dhcp-server-properties-start.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dhcp-server/properties/start")     |
| [end](#end)         | Merged    | Required | cannot be null | [Configuration of dnsmasq](get-configuration-properties-dhcp-server-properties-end.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dhcp-server/properties/end")         |
| [lease](#lease)     | `integer` | Required | cannot be null | [Configuration of dnsmasq](get-configuration-properties-dhcp-server-properties-lease.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dhcp-server/properties/lease")     |

## enabled

Enable DHCP server

`enabled`

*   is required

*   Type: `boolean`

*   cannot be null

*   defined in: [Configuration of dnsmasq](get-configuration-properties-dhcp-server-properties-enabled.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dhcp-server/properties/enabled")

### enabled Type

`boolean`

## start



`start`

*   is required

*   Type: `string` ([Details](get-configuration-properties-dhcp-server-properties-start.md))

*   cannot be null

*   defined in: [Configuration of dnsmasq](get-configuration-properties-dhcp-server-properties-start.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dhcp-server/properties/start")

### start Type

`string` ([Details](get-configuration-properties-dhcp-server-properties-start.md))

one (and only one) of

*   [Untitled undefined type in Configuration of dnsmasq](get-configuration-properties-dhcp-server-properties-start-oneof-0.md "check type definition")

*   [Untitled undefined type in Configuration of dnsmasq](get-configuration-properties-dhcp-server-properties-start-oneof-1.md "check type definition")

## end



`end`

*   is required

*   Type: `string` ([Details](get-configuration-properties-dhcp-server-properties-end.md))

*   cannot be null

*   defined in: [Configuration of dnsmasq](get-configuration-properties-dhcp-server-properties-end.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dhcp-server/properties/end")

### end Type

`string` ([Details](get-configuration-properties-dhcp-server-properties-end.md))

one (and only one) of

*   [Untitled undefined type in Configuration of dnsmasq](get-configuration-properties-dhcp-server-properties-end-oneof-0.md "check type definition")

*   [Untitled undefined type in Configuration of dnsmasq](get-configuration-properties-dhcp-server-properties-end-oneof-1.md "check type definition")

## lease

Lease time in hours

`lease`

*   is required

*   Type: `integer`

*   cannot be null

*   defined in: [Configuration of dnsmasq](get-configuration-properties-dhcp-server-properties-lease.md "http://schema.nethserver.org/dnsmasq/get-configuration.json#/properties/dhcp-server/properties/lease")

### lease Type

`integer`

### lease Constraints

**minimum**: the value of this number must greater than or equal to: `1`
