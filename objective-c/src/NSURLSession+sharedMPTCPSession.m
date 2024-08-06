//
//  NSURLSession+sharedMPTCPSession.m
//  mptcp-test
//
//  Created by Anthony Doeraene on 05/08/2024.
//

#import <Foundation/Foundation.h>
#include "NSURLSession+sharedMPTCPSession.h"
#include "NSURLSessionConfiguration+default.h"

@implementation NSURLSession (sharedMPTCPSession)
+ (NSURLSession *) sharedMPTCPSession {
    static NSURLSession *sharedMPTCPSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultMPTCPConfiguration];
        // create a session with the MPTCP configuration if MPTCP is enabled, else fall back to TCP
        sharedMPTCPSession = [NSURLSession sessionWithConfiguration:conf];
    });
    return sharedMPTCPSession;
}
@end
