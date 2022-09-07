# Using Multipath TCP in C


It is pretty simple to use Multipath TCP with the C language. You simply need to pass IPPROTO_MPTCP as the third argument of the [socket()](https://www.man7.org/linux/man-pages/man3/socket.3p.html) system call. Make sure that IPPROTO_MPTCP is correctly defined and if you, define it as follows :

```
#ifndef IPPROTO_MPTCP
#define IPPROTO_MPTCP 262
#endif
```

A typical socket call for Multipath TCP will look like: `    s = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); `

The [simple project](src/) in this repository also illustrates how to automatically check with autoconf whether the compilation is on a Multipath TCP enabled host.

