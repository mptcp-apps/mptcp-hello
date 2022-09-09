#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>       
#include <sys/socket.h>
#include <stdbool.h>
#include <netinet/in.h>
#include <errno.h>

// IPPROTO_MPTCP is defined in <netinet/in.h> on recent kernels only

#ifndef IPPROTO_MPTCP
#define IPPROTO_MPTCP 262
#endif



/*
 * Create a Multipath TCP socket for the specified domain 
 * If the creation fails because Multipath TCP is not supported
 * on this system, falls back to regular TCP
 */
int socket_create(int domain) {

  // if true, try always enable Multipath TCP for TCP sockets
  static bool use_mptcp = true;
  int s;
  if(use_mptcp) {
    s = socket(domain, SOCK_STREAM, IPPROTO_MPTCP);
    if(s==-1 && ( errno==EPROTONOSUPPORT || errno==ENOPROTOOPT) ) {
      // Multipath TCP is not supported on this system
      use_mptcp = false;
      // Fall back to regular TCP      
    } else {
      // Multipath TCP socket was created or another error occured
      return s;
    }
  }
  // Multipath TCP is not supported on this system, return a TCP socket
  return(socket(domain, SOCK_STREAM, IPPROTO_TCP));
  
}

int main(int argc, char **argv) {
  
  int s;

  
  
  s = socket_create(AF_INET);

  // do something useful with the socket
  
  close(s);
  
}
