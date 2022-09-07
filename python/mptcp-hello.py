import socket

# On python 3.10 and above, IPPROTO_MPTCP is defined, 
# s = socket.socket(socket.AF_INET, socket.SOCK_STREAM, IPPROTO_MPTCP)
# Otherwise, you need to define the constant your self

mptcp_protocol = 262
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM, mptcp_protocol)

s.connect(("test.multipath-tcp.org" , 80))

# use the socket as you wish

s.close()
