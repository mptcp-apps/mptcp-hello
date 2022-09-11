//! This example is a modified version of:
//! https://github.com/hyperium/hyper/blob/0.14.x/examples/hello.rs

use hyper::service::{make_service_fn, service_fn};
use hyper::{Body, Request, Response, Server};
use socket2::{Domain, Protocol, Socket, Type};
use std::convert::Infallible;

async fn hello(_: Request<Body>) -> Result<Response<Body>, Infallible> {
    Ok(Response::new(Body::from("Hello MPTCP!")))
}

#[tokio::main]
pub async fn main() -> Result<(), Box<dyn std::error::Error + Send + Sync>> {
    let addr = ([127, 0, 0, 1], 3000).into();

    let make_svc = make_service_fn(|_| async { Ok::<_, Infallible>(service_fn(hello)) });

    // Create the MPTCP capable socket but allow for a fallback to
    // TCP if the host does not support MPTCP.
    let socket = match Socket::new(
        Domain::for_address(addr),
        Type::STREAM,
        Some(Protocol::MPTCP),
    ) {
        Ok(socket) => socket,
        Err(err) => {
            eprintln!(
                "Unable to create an MPTCP socket, fallback to regular TCP socket: {}",
                err
            );
            Socket::new(Domain::for_address(addr), Type::STREAM, Some(Protocol::TCP))?
        }
    };
    // Set common options on the socket as we created it by hand.
    socket.set_nonblocking(true)?;
    socket.set_reuse_address(true)?;
    socket.bind(&addr.into())?;
    socket.listen(1024)?;

    let server = Server::from_tcp(socket.into())?.serve(make_svc);

    println!("Listening on http://{}", addr);

    server.await?;
    Ok(())
}
