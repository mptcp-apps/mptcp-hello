# Using Multipath TCP in Swift on iOS

To use Multipath TCP in Swift, you simply need to change a bit the configuration given to `URLSession`, by selecting a Multipath TCP mode. The list of available modes is given in [the official documentation](https://developer.apple.com/documentation/foundation/urlsessionconfiguration/multipathservicetype). Note however that enabling MPTCP on `URLSession` can only be done on iOS. Here is an example:

```swift
var conf = URLSessionConfiguration.default
#if os(iOS)
    // multipath is only available on iOS, enable it only in this case
    conf.multipathServiceType = .handover
#endif

let session = URLSession(configuration: conf)
```

In this repository, you'll also find extensions to `URLSession` and `URLSessionConfiguration`, which allows having a single shared instance, called `sharedMPTCP`, for `URLSession` with Multipath TCP enabled in handover mode.

Please, note however that the aggregate mode doesn't seem to work according to our tests. It may be needed to add the [according entitlements in Xcode](https://developer.apple.com/documentation/foundation/urlsessionconfiguration/improving_network_reliability_using_multipath_tcp) in order to work, but we didn't test it yet.
Another remark: only client side MPTCP is supported currently.