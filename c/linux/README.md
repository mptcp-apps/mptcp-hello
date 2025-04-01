# Using Multipath TCP in C


It is pretty simple to use Multipath TCP with the C language. You simply need to
pass `IPPROTO_MPTCP` as the third argument of the
[`socket()`](https://www.man7.org/linux/man-pages/man3/socket.3p.html) system
call. Make sure that `IPPROTO_MPTCP` is correctly defined and, if needed, define
it as follows :

```c
#ifndef IPPROTO_MPTCP
#define IPPROTO_MPTCP 262
#endif
```

A typical socket call for Multipath TCP will look like:

```c
s = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
```

Note: because the build and run-time environments might be different, it is not
recommended to check if the kernel at build time supports MPTCP. The kernel at
run-time might be different, or the kernel might be updated later.
