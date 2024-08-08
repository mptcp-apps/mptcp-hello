#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>       
#include <sys/socket.h>
#include <stdbool.h>
#include <netinet/in.h>


#ifndef IPPROTO_MPTCP
#define IPPROTO_MPTCP 262
#endif




bool use_mptcp = true;

int main(int argc, char **argv) {
  
  int s;

  
  if (use_mptcp) {
    s = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
    if (s == -1) {
      use_mptcp = false;
      fprintf(stderr, "Could not create MPTCP socket, falling back to TCP \n");
      s = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
      if (s ==-1) {
	fprintf(stderr, "Could not create TCP socket\n");
	exit(-1);
      }
    }
    close(s);
    exit(0);
  }
}
