# Using Multipath TCP in Go

To use Multipath TCP in Go, you can create the socket manually with syscalls
like you would do in other languages but this is not an usual and practical way.

Instead, from Go 1.21, MPTCP support has been added in the net package:

- https://go.dev/issue/56539
- https://go.dev/issue/59166

Examples:

- [simple client](mptcp-client.go)
- [simple server](mptcp-server.go)
