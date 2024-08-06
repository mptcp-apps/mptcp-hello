# Hello Multipath TCP!

Multipath TCP (MPTCP) is a TCP extension specified in [RFC8684](https://www.rfc-editor.org/rfc/rfc8684.html) that allows a TCP connection to use different paths such as Wi-Fi and cellular on smartphones or Wi-Fi and Ethernet on laptops. Multipath TCP is supported by Linux kernel versions >=5.6 and enabled on many popular distributions. It is also possible for applications to use it on iOS >= 11 for the client side only.

The utilization of Multipath TCP is negotiated during the TCP three-way handshake. This implies that if a Multipath TCP client contacts a regular TCP server, they will use a regular TCP connection. Similarly, if a regular TCP client contacts a Multipath TCP server, they will use a regular TCP connection. Multipath TCP will only be used if both the client and the server support Multipath TCP.

Enabling Multipath TCP in an applications on an operating system supporting it is easy: MPTCP has to be enabled before creating the connection. On Linux, applications must pass `IPPROTO_MPTCP` as the third parameter of the [socket()](https://www.man7.org/linux/man-pages/man3/socket.3p.html) system call. On iOS, the [`MultiPath Service`](https://developer.apple.com/documentation/foundation/nsurlsessionmultipathservicetype) should be enabled. For more details about that: please check the [mptcp.dev](https://mptcp.dev) website.

The following examples show how enable Multipath TCP with different programming languages:

- On Linux
  - [Using Multipath TCP in C](c/README.md)
  - [Using Multipath TCP in python](python/README.md)
  - [Using Multipath TCP in perl](perl/README.md)
  - [Using Multipath TCP in Rust](rust/README.md)

- On iOS
  - [Using Multipath TCP in objective-C](objective-c/README.md)
  - [Using Multipath TCP in Swift](swift/README.md)



If you do not have access to the application's source code, you can use [mptcpize](https://manpages.ubuntu.com/manpages/kinetic/en/man8/mptcpize.8.html) on Linux to automatically transform the TCP socket system calls into Multipath TCP sockets.

The implementation of Multipath TCP in the Linux kernel is regularly improved. You can track the changes [here](https://github.com/multipath-tcp/mptcp_net-next/wiki#changelog).

