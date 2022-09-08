import socket
import errno

# By default, the application wishes to use Multipath TCP for all sockets
# provided that it is running on a system that supports Multipath TCP
_use_mptcp = True


def create_socket(sockaf):
  global _use_mptcp  
  # On Python 3.10 and above, socket.IPPROTO_MPTCP is defined.
  # If not, we set it manually
  try:
    mptcp_protocol = socket.IPPROTO_MPTCP
  except AttributeError:
    mptcp_protocol = 262
  # If Multipath TCP is enabled on this system, we create a Multipath TCP
  # socket
  if _use_mptcp :  
    try:
      return socket.socket(sockaf, socket.SOCK_STREAM, mptcp_protocol)
    except OSError as e:
      # Multipath TCP is not supported, we fall back to regular TCP
      # and remember that Multipath TCP is not enabled
      if e.errno == errno.ENOPROTOOPT or e.errno == errno.ENOPROTONOSUPPORT :
        _use_mptcp = False
      return socket.socket(sockaf, socket.SOCK_STREAM, socket.IPPROTO_TCP)
  else:
    # We already know that Multipath TCP does not work on this system
    return socket.socket(sockaf, socket.SOCK_STREAM, socket.IPPROTO_TCP)

    
s = create_socket(socket.AF_INET)
s.connect(("test.multipath-tcp.org" , 80))

# use the socket as you wish

s.close()
