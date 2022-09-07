use Socket qw(PF_INET SOCK_STREAM pack_sockaddr_in inet_aton);

#IPPROTO_MPTCP=262;
print "\n";
socket(my $socket, PF_INET, SOCK_STREAM, 262)
    or die "socket: $!";

my $port = getservbyname "http", "tcp";
connect($socket, pack_sockaddr_in($port, inet_aton("ovh")))
    or die "connect: $!";

print $socket "Hello, world!\n";
print <$socket>;
