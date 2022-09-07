# Using Multipath TCP in python


To use Multipath TCP in python, simply pass Multipath TCP's protocol number (262) as the third argument of the socket system call. On python 3.10+, you can even use IPPROTO_MPTCP as the third argument since this constant is defined in python 3.10+.

 [simple example](hello-mptcp.py)