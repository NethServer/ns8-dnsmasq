# Get DNS records Schema

```txt
http://schema.nethserver.org/dnsmasq/get-dns-records.json
```

Get a list of static DNS entries

| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                  |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :-------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [get-dns-records.json](dnsmasq/get-dns-records.json "open original schema") |

## Get DNS records Type

`object` ([Get DNS records](get-dns-records.md))

# Get DNS records Properties

| Property            | Type    | Required | Nullable       | Defined by                                                                                                                               |
| :------------------ | :------ | :------- | :------------- | :--------------------------------------------------------------------------------------------------------------------------------------- |
| [records](#records) | `array` | Required | cannot be null | [Get DNS records](get-dns-records-properties-records.md "http://schema.nethserver.org/dnsmasq/get-dns-records.json#/properties/records") |

## records

List of static DNS entries

`records`

* is required

* Type: `object[]` ([Details](get-dns-records-properties-records-items.md))

* cannot be null

* defined in: [Get DNS records](get-dns-records-properties-records.md "http://schema.nethserver.org/dnsmasq/get-dns-records.json#/properties/records")

### records Type

`object[]` ([Details](get-dns-records-properties-records-items.md))
