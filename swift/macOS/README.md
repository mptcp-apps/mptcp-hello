# Using Multipath TCP in Swift on macOS/iOS

To use Multipath TCP in Swift, you simply need to change a bit the configuration given to the connection, by selecting a Multipath TCP mode. The list of available modes is given in [the official documentation](https://developer.apple.com/documentation/network/nwparameters/multipathservicetype). Here is an example:

```swift
// request to create a new TCP connection
// note that we can also choose .tls to create a TLS session above (MP)TCP
let params: NWParameters = .tcp 
// Handover mode: Other types can be selected
params.multipathServiceType = .handover

let connection = NWConnection(to: server, using: params)
```

Please, note however that the aggregate mode doesn't seem to work according to our tests.