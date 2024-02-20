import socket
import errno

# On Python 3.10 and above, socket.IPPROTO_MPTCP is defined.
# If not, we set it manually
try:
  IPPROTO_MPTCP = socket.IPPROTO_MPTCP
except AttributeError:
  IPPROTO_MPTCP = 262

# By default, the application wishes to use Multipath TCP for all sockets
# provided that it is running on a system that supports Multipath TCP
_use_mptcp = True
  
def create_socket(sockaf):
  global _use_mptcp
  global IPPROTO_MPTCP
  # If Multipath TCP is enabled on this system, we create a Multipath TCP
  # socket
  if _use_mptcp :  
    try:
      return socket.socket(sockaf, socket.SOCK_STREAM, IPPROTO_MPTCP)
    except OSError as e:
      # Multipath TCP is not supported, we fall back to regular TCP
      # and remember that Multipath TCP is not enabled
      if e.errno == errno.ENOPROTOOPT or \
         e.errno == errno.EPROTONOSUPPORT or \
         e.errno == errno.EINVAL:
        _use_mptcp = False
        
  # Multipath TCP does not work or socket failed, we try TCP
  return socket.socket(sockaf, socket.SOCK_STREAM, socket.IPPROTO_TCP)

#
# Example usage
#
s = create_socket(socket.AF_INET)
s.connect(("test.multipath-tcp.org" , 80))

# use the socket as you wish

s.close()
