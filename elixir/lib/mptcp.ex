# Author: Anthony Doeraene <anthony.doeraene@hotmail.com>

defmodule MPTCP do
  @ipproto_mptcp 262

  defp open_socket() do
    {status, sock} = :socket.open(:inet, :stream, @ipproto_mptcp)
    case status do
      :ok -> {:ok, sock}
      _ -> :socket.open(:inet, :stream, 0)
    end
  end

  def client(addr, port) do
    {:ok, sock} = open_socket()
    :ok = :socket.connect(sock, %{family: :inet,
                                addr: addr,
                                port: port})
    msg = <<"hello">>
    :ok = :socket.send(sock, msg)
    :ok = :socket.shutdown(sock, :write)
    {:ok, msg} = :socket.recv(sock)
    :ok = :socket.close(sock)
    msg
  end

  def server(addr, port) do
    {:ok, lsock} = open_socket()
    :ok = :socket.bind(lsock, %{family: :inet,
                              port: port,
                              addr: addr})
    :ok = :socket.listen(lsock)
    {:ok, sock} = :socket.accept(lsock)
    {:ok, msg} = :socket.recv(sock)
    :ok = :socket.send(sock, msg)
    :ok = :socket.close(sock)
    :ok = :socket.close(lsock)
  end
end
