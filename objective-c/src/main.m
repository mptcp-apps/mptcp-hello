//
//  main.m
//  mptcp-test
//
//  Created by Anthony Doeraene on 05/08/2024.
//

#import <Foundation/Foundation.h>
#include "NSURLSession+sharedMPTCPSession.h"
#include "NSURLSessionConfiguration+default.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        NSURL *url = [NSURL URLWithString:@"https://check.mptcp.dev"];
        
        // do a get request to https://check.mptcp.dev
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setHTTPMethod:@"GET"];
        [request setURL:url];
        [request setValue:@"curl/1.0.0" forHTTPHeaderField:@"User-Agent"];
        
        NSURLSession *session = [NSURLSession sharedMPTCPSession];
        // alternatively, to create a new session you can use:
        // NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultMPTCPConfiguration]];

        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:
          ^(NSData * _Nullable data,
            NSURLResponse * _Nullable response,
            NSError * _Nullable error) {

              NSString *res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              NSLog(@"Data received: %@", res);
              dispatch_semaphore_signal(semaphore);
        }];
        [dataTask resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
    
    return 0;
}
