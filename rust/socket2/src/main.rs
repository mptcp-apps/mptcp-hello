use std::net::SocketAddr;

use once_cell::sync::OnceCell;
use socket2::{Domain, Protocol, Socket, Type};

static USE_MPTCP: OnceCell<bool> = OnceCell::new();

/// Create a Multiple Path TCP socket for the specified domain
///
/// Note that it will depends on the USE_MPTCP value. At program
/// startup the USE_MPTCP will be empty, thus will be considered
/// as `true`. If the MPTCP socket creation fails, it will fallback
/// to regular TCP.
/// And in the case where the socket creation fails (for MPTCP)
/// because the protocol is not supported by the host, it will
/// set the USE_MPTCP to `false` so that it won't try on other
/// calls.
fn socket_create(domain: Domain) -> std::io::Result<Socket> {
    if *USE_MPTCP.get().unwrap_or(&true) {
        match Socket::new(domain, Type::STREAM, Some(Protocol::MPTCP)) {
            Ok(sock) => return Ok(sock),
            Err(err) => {
                eprintln!(
                    "Unable to create an MPTCP socket, fallback to regular TCP socket: {}",
                    err
                );

                if let Some(err_code) = err.raw_os_error() {
                    if err_code == libc::ENOPROTOOPT || err_code == libc::EPROTONOSUPPORT {
                        _ = USE_MPTCP.set(false);
                    }
                }
            }
        }
    }

    Socket::new(domain, Type::STREAM, Some(Protocol::TCP))
}

fn main() -> std::io::Result<()> {
    let socket = socket_create(Domain::IPV4)?;

    // Do anything with the Socket.
    // By example, connect to test.multipath-tcp.org.
    // note: you can dynamically get the IP address using a resolver
    //		 but for the simplicity of this example, I've already done
    //		 the conversion.
    let addr: SocketAddr = ([5, 196, 67, 207], 80).into();
    match socket.connect(&addr.into()) {
        Ok(_) => {}
        Err(err) => {
            eprintln!("Failed to connect to the SocketAddr");
            return Err(err);
        }
    }

    Ok(())
}
