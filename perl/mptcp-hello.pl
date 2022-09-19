use Socket qw(PF_INET SOCK_STREAM pack_sockaddr_in inet_aton);

use Net::protoent;
$p = getprotobyname(shift || 'mptcp') || die "no proto";
printf "proto for %s is %d, aliases are %s\n",
   $p->name, $p->proto, "@{$p->aliases}";

use constant IPPROTO_MPTCP => 262;

my $proto;
if(defined getprotobyname( shift || 'mptcp' )) {
    $proto = getprotobyname (shift || 'mptcp' );
}
else
    $proto = ('mptcp', "MPTCP", 262);
}
    

socket(my $socket, PF_INET, SOCK_STREAM, $proto)
    or die "socket: $!";



#socket(my $socket, PF_INET, SOCK_STREAM, IPROTO_MPTCP)
#    or die "socket: $!";

my $port = getservbyname "http", "tcp";
connect($socket, pack_sockaddr_in($port, inet_aton("test.multipath-tcp.org")))
    or die "connect: $!";


print $socket "GET / HTTP/1.0\r\n\r\n";
print <$socket>;
