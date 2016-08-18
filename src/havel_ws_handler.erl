-module(havel_ws_handler).

-behaviour(cowboy_websocket_handler).

-include("havel_logger.hrl").

-export([init/3]).
-export([websocket_init/3]).
-export([websocket_info/3]).
-export([websocket_handle/3]).
-export([websocket_terminate/3]).

init(Type, Req, Opt) ->
    ?INFO_MSG("~p", [Type]),
    {upgrade, protocol, cowboy_websocket, Req, Opt}.

websocket_init(Type, Req, State) ->
    ?INFO_MSG("~p", [Type]),
    {ok, Req, State}.

websocket_handle(Data, Req, State) ->
    ?INFO_MSG("~p", [Data]),
    {ok, Req, State}.

websocket_info(Info, Req, State) ->
    ?INFO_MSG("~p", [Info]),
    {ok, Req, State}.

websocket_terminate(Reason, _Req, _State) ->
    ?INFO_MSG("~p", [Reason]),
    ok.
