//
//  NSURLSessionConfiguration+default.h
//  mptcp-test
//
//  Created by Anthony Doeraene on 05/08/2024.
//

#ifndef NSURLSessionConfiguration_default_h
#define NSURLSessionConfiguration_default_h
// add a static var defaultMPTCPConfiguration to NSURLSessionConfiguration
@interface NSURLSessionConfiguration (defaultMPTCPConfiguration)
+ (NSURLSessionConfiguration *) defaultMPTCPConfiguration;
@end
#endif /* NSURLSessionConfiguration_default_h */
