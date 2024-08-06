//
//  NSURLSession+sharedMPTCPSession.h
//  mptcp-test
//
//  Created by Anthony Doeraene on 05/08/2024.
//

#ifndef NSURLSession_sharedMPTCPSession_h
#define NSURLSession_sharedMPTCPSession_h

@interface NSURLSession (sharedMPTCPSession)
+ (NSURLSession *) sharedMPTCPSession;
@end

#endif /* NSURLSession_sharedMPTCPSession_h */
