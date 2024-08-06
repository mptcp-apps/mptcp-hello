# Using Multipath TCP in Objective-C

To use Multipath TCP in Objective-C, you simply need to change a bit the configuration given to `NSURLSession`, by selecting a Multipath TCP mode. The list of available modes is given in [the official documentation](https://developer.apple.com/documentation/foundation/nsurlsessionmultipathservicetype) Note however that Multipath TCP is only available if the target platform is an iOS device, so it might be interesting to use a macro that enables it only if we are building for iOS. Here is an example:

```objc
NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];

#if TARGET_OS_IOS
    // multipath is only supported in iOS
    conf.multipathServiceType = NSURLSessionMultipathServiceTypeHandover;
#endif

NSURLSession *session = [NSURLSession sessionWithConfiguration:conf];
```

In this repository, you'll also find categories that extend the `NSURLSession` and `NSURLSessionConfiguration`, which allows having a single shared instance, called `sharedMPTCPSession`, for `NSURLSession` with Multipath TCP enabled in handover mode.