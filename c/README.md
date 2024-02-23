# Using Multipath TCP in C


It is pretty simple to use Multipath TCP with the C language. You simply need to pass IPPROTO_MPTCP as the third argument of the [socket()](https://www.man7.org/linux/man-pages/man3/socket.3p.html) system call. Make sure that IPPROTO_MPTCP is correctly defined and if not, define it as follows :

```
#ifndef IPPROTO_MPTCP
#define IPPROTO_MPTCP 262
#endif
```

A typical socket call for Multipath TCP will look like: `s = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); `

Most networked applications abstract the creation of a TCP socket in a specific function that is called instead of calling [socket()](https://www.man7.org/linux/man-pages/man3/socket.3p.html) directly. This is a good opportunity to make the code portable and useable on hosts that support Multipath TCP or not. In practice, to efficiently enable Multipath TCP, your code should try to use Multipath TCP when creating the first TCP socket. If this socket is successfully created, then Multipath TCP is enabled on the host and you can continue to use Multipath TCP. Otherwise, the application is running on a host that does not yet support Multipath TCP. In this unfortunate case, you should fall back to regular TCP and always create TCP sockets. You might print an error message to encourage the user to upgrade his/her system to support Multipath TCP...

The [simple project](mptcphello.c) in this repository illustrates this strategy. If you want to automatically check with autoconf whether the compilation is on a Multipath TCP enabled host, see [configure.ac](configure.ac)

