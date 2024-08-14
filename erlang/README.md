# Using MPTCP in erlang

It is pretty simple to use Multipath TCP with erlang as the API is closely related to C. You simply need to pass the value 262 (=IPPROTO_MPTCP) as the third argument of the [socket:open](https://www.erlang.org/doc/apps/kernel/socket.html#open/3) function.

A typical socket call for Multipath TCP will look like: `{:ok, sock} = socket:open(inet, stream, 262)`

This simple project also shows how to fallback automatically to TCP in case of MPTCP not being available.

## Run a server

Here is an example on how to run a MPTCP server listening on 192.168.0.100:8080 using this example.

```erl
# erl

1> c(mptcp).
2> mptcp:server({192, 168, 0, 100}, 8080).
```

## Run a client

Here is an example on how to run a MPTCP client connecting to 192.168.0.100:8080 using this example.

```erl
# erl

1> c(mptcp).
2> mptcp:client({192, 168, 0, 100}, 8080).
```