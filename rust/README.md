# Using Multipath TCP in Rust


Rust and C are pretty much the same for the No framework example. You simply need to open a socket with the `IPPROTO_MPTCP` protocol. For that you can use the `Socket2` library [see here](Socket2).

If you plan to use a more complex library (HTTP library, Web framework, ...), it may not be as straigthforward as just using `Socket2`. Let's take `Hyper` for example, they support differents IO type, allowing you to create a `Socket2`'s socket and pass it to [Server::from_tcp](https://docs.rs/hyper/0.14.20/hyper/server/struct.Server.html#method.from_tcp).

- [No framework example (socket2)](socket2)
- [Hyper framework (server)](hyper_server)