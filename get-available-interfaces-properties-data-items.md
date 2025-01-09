# Untitled object in Interfaces Schema

```txt
http://schema.nethserver.org/dnsmasq/get-available-interfaces.json#/properties/data/items
```

Interface configuration to pass to the UI.

| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                                      |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :---------------------------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [get-available-interfaces.json\*](dnsmasq/get-available-interfaces.json "open original schema") |

## items Type

`object` ([Details](get-available-interfaces-properties-data-items.md))

# items Properties

| Property            | Type     | Required | Nullable       | Defined by                                                                                                                                                                                        |
| :------------------ | :------- | :------- | :------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [name](#name)       | `string` | Required | cannot be null | [Interfaces](get-available-interfaces-properties-data-items-properties-name.md "http://schema.nethserver.org/dnsmasq/get-available-interfaces.json#/properties/data/items/properties/name")       |
| [network](#network) | `string` | Required | cannot be null | [Interfaces](get-available-interfaces-properties-data-items-properties-network.md "http://schema.nethserver.org/dnsmasq/get-available-interfaces.json#/properties/data/items/properties/network") |

## name

Interface name

`name`

* is required

* Type: `string`

* cannot be null

* defined in: [Interfaces](get-available-interfaces-properties-data-items-properties-name.md "http://schema.nethserver.org/dnsmasq/get-available-interfaces.json#/properties/data/items/properties/name")

### name Type

`string`

## network

Network ip/netmask

`network`

* is required

* Type: `string`

* cannot be null

* defined in: [Interfaces](get-available-interfaces-properties-data-items-properties-network.md "http://schema.nethserver.org/dnsmasq/get-available-interfaces.json#/properties/data/items/properties/network")

### network Type

`string`
