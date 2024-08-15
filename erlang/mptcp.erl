%%% @author Anthony Doerane <anthony.doeraene@hotmail.com>

-module(mptcp).
-export([client/2, server/2]).

-define(IPPROTO_MPTCP, 262).

open_socket() ->
   {Status, Sock} = socket:open(inet, stream, ?IPPROTO_MPTCP),
   case Status of
      ok -> {Status, Sock};
      _ -> socket:open(inet, stream, 0)
   end.

client(SAddr, SPort) ->
   {ok, Sock} = open_socket(),
   ok = socket:connect(Sock, #{family => inet,
                               addr   => SAddr,
                               port   => SPort}),
   Msg = <<"hello">>,
   ok = socket:send(Sock, Msg),
   ok = socket:shutdown(Sock, write),
   {ok, Msg} = socket:recv(Sock),
   ok = socket:close(Sock).

server(Addr, Port) ->
   {ok, LSock} = open_socket(),
   ok = socket:bind(LSock, #{family => inet,
                             port   => Port,
                             addr   => Addr}),
   ok = socket:listen(LSock),
   {ok, Sock} = socket:accept(LSock),
   {ok, Msg} = socket:recv(Sock),
   ok = socket:send(Sock, Msg),
   ok = socket:close(Sock),
   ok = socket:close(LSock).
