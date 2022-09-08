# Using Multipath TCP in python

To use Multipath TCP in python, you need to pass IPPROTO_MPTCP as the third argument of the socket.socket call as in C. On python 3.10+, this is as
simple as :

```
socket.socket(sockaf, socket.SOCK_STREAM, IPPROTO_MPTCP)
```

However, if you want your code to be portable and to run on hosts using older Linux kernels or where Multipath TCP is disabled, you need to take some care. Here are some hints that you might find useful :

1. Do not simply use IPPROTO_MPTCP, use a try ... except and set a variable to the expected value of IPPROTO_MPTCP like

  ```
  try:
	_mptcp_protocol = socket.IPPROTO_MPTCP
  except AttributeError:
        _mptcp_protocol = 262
  ```

  Although 262 alone would work, using it directly in your make would make it unreadable.

2. Since the Multipath TCP support is a system property, you should only test it once. If your application creates several TCP sockets and you want to add support for Multipath TCP, you should use a function that creates all the sockets that you need. When first called, this function will try to create a Multipath TCP socket. If this socket fails with either ```ENOPROTOOPT 92 Protocol not available``` or ```EPROTONOSUPPORT 93 Protocol not supported```, this means that it runs on a system that does not support Multipath TCP. You should fallback to TCP and return a regular TCP socket and cache this information such you automatically create TCP sockets at the next calls.

 [simple example](mptcp-hello.py)