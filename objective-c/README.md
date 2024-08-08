# Using Multipath TCP in Objective-C on iOS

To use Multipath TCP in Objective-C, you simply need to change a bit the configuration given to `NSURLSession`, by selecting a Multipath TCP mode. The list of available modes is given in [the official documentation](https://developer.apple.com/documentation/foundation/nsurlsessionmultipathservicetype).

Currently, enabling MPTCP on `NSURLSession` can only be done on **iOS**, **not OSX**.

Here is an example:

```objc
NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];

#if TARGET_OS_IOS
    // multipath is only supported in iOS
    conf.multipathServiceType = NSURLSessionMultipathServiceTypeHandover;
#endif

NSURLSession *session = [NSURLSession sessionWithConfiguration:conf];
```

In this repository, you'll also find categories that extend the `NSURLSession` and `NSURLSessionConfiguration`, which allows having a single shared instance, called `sharedMPTCPSession`, for `NSURLSession` with Multipath TCP enabled in handover mode.
Another remark: currently, only the client side is supported.