# Hello Multipath TCP !

Multipath TCP is a TCP extension specified in [RFC8684](https://www.rfc-editor.org/rfc/rfc8684.html) that allows a TCP connection to use different paths such as Wi-Fi and cellular on smartphones or Wi-Fi and Ethernet on laptops. Multipath TCP is supported by Linux kernel versions >5.15 and enabled on many popular distributions.

The utilization of Multipath TCP is negotiated during the TCP three-way handshake. This implies that if a Multipath TCP client contacts a regular TCP server, they will use a regular TCP connection. Similarly, if a regular TCP client contacts a Multipath TCP server, they will use a regular TCP connection. Multipath TCP will only be used if both the client and the server support Multipath TCP.

Two steps are required to use Multipath TCP on a host with a recent Linux kernel. First, the net.mptcp.enabled sysctl variable must be set to 1 :

    sysctl net.mptcp.enabled=1

Second, the application must pass IPPROTO_MPTCP as the third parameter of the [socket()](https://www.man7.org/linux/man-pages/man3/socket.3p.html) system call.

The following examples show how enable Multipath TCP with different programming languages:

 - [Using Multipath TCP in C](c/README.md)
 - [Using Multipath TCP in python](python/README.md)
 - [Using Multipath TCP in perl](perl/README.md)
 


If you do not have access to the application's source code, you can use [mptcpize](https://manpages.ubuntu.com/manpages/kinetic/en/man8/mptcpize.8.html) to automatically transform the TCP socket system calls into Multipath TCP sockets. 

The implementation of Multipath TCP in the Linux kernel is regularly improved. You can track the changes at https://github.com/multipath-tcp/mptcp_net-next/wiki


