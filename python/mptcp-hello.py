import socket

# On Python 3.10 and above, socket.IPPROTO_MPTCP is defined.
# If not, we set it manually
try:
  mptcp_protocol = socket.IPPROTO_MPTCP
except AttributeError:
  mptcp_protocol = 262

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM, mptcp_protocol)

s.connect(("test.multipath-tcp.org" , 80))

# use the socket as you wish

s.close()
