# Using Multipath TCP in python

To use Multipath TCP in python, you need to pass ```IPPROTO_MPTCP``` as the third argument of the ```socket.socket``` call as in C. On python 3.10+, this is as
simple as :

```python
socket.socket(sockaf, socket.SOCK_STREAM, socket.IPPROTO_MPTCP)
```

However, if you want your code to be portable and to run on hosts using older Linux kernels, kernels where Multipath TCP is disabled or older versions of python, you need to take some care. Here are some hints that you might find useful :

1. Do not simply use ```socket.IPPROTO_MPTCP```, use a ```try ... except``` and set a variable to the expected value of ```socket.IPPROTO_MPTCP``` like

  ```python
  try:
	IPPROTO_MPTCP = socket.IPPROTO_MPTCP
  except AttributeError:
        IPPROTO_MPTCP = 262
  ```

  Although 262 alone would work, using it directly in your make would make it unreadable.

2. Since the Multipath TCP support is a system property, you should only test it once. If your application creates several TCP sockets and you want to add support for Multipath TCP, you should use a function that creates all the sockets that you need. This function tries to create a Multipath TCP socket. If this socket fails with either ```ENOPROTOOPT 92 Protocol not available``` (linked to `sysctl net.mptcp.enabled`), ```EPROTONOSUPPORT 93 Protocol not supported``` (MPTCP is not compiled on >=v5.6) or ```EINVAL 22 Invalid argument``` (MPTCP is not available on <5.6), this means that it runs on a system that does not support Multipath TCP. You should fallback to TCP and return a regular TCP socket and cache this information such you automatically create TCP sockets at the next calls.

 [simple example](mptcp-hello.py)
