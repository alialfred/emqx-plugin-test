-module(emqx_auth_demo).

-behaviour(emqx_auth_mod).

-include_lib("emqx/include/emqx.hrl").

-export([init/1, check/3, description/0]).

init(Opts) -> {ok, Opts}.

check(#mqtt_client{client_id = ClientId, username = Username}, Password, _Opts) ->
    io:format("Auth Demo: clientId=~p, username=~p, password=~p~n",
              [ClientId, Username, Password]),
    ok.

description() -> "Demo Auth Module".
