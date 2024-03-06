# Untitled object in Configure dnsmasq Schema

```txt
http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server
```

Defines DNS server configuration

| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                      |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :------------------------------------------------------------------------------ |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [configure-module.json\*](dnsmasq/configure-module.json "open original schema") |

## dns-server Type

`object` ([Details](configure-module-properties-dns-server.md))

# dns-server Properties

| Property                              | Type      | Required | Nullable       | Defined by                                                                                                                                                                                                 |
| :------------------------------------ | :-------- | :------- | :------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [enabled](#enabled)                   | `boolean` | Required | cannot be null | [Configure dnsmasq](configure-module-properties-dns-server-properties-enabled.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server/properties/enabled")                   |
| [primary-server](#primary-server)     | `string`  | Required | cannot be null | [Configure dnsmasq](configure-module-properties-dns-server-properties-primary-server.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server/properties/primary-server")     |
| [secondary-server](#secondary-server) | `string`  | Required | cannot be null | [Configure dnsmasq](configure-module-properties-dns-server-properties-secondary-server.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server/properties/secondary-server") |

## enabled

Enable DNS server

`enabled`

*   is required

*   Type: `boolean`

*   cannot be null

*   defined in: [Configure dnsmasq](configure-module-properties-dns-server-properties-enabled.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server/properties/enabled")

### enabled Type

`boolean`

## primary-server

Primary DNS server

`primary-server`

*   is required

*   Type: `string`

*   cannot be null

*   defined in: [Configure dnsmasq](configure-module-properties-dns-server-properties-primary-server.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server/properties/primary-server")

### primary-server Type

`string`

## secondary-server

Secondary DNS server

`secondary-server`

*   is required

*   Type: `string`

*   cannot be null

*   defined in: [Configure dnsmasq](configure-module-properties-dns-server-properties-secondary-server.md "http://schema.nethserver.org/dnsmasq/configure-module.json#/properties/dns-server/properties/secondary-server")

### secondary-server Type

`string`
