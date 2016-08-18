-module(havel_ws_handler).

-behaviour(cowboy_websocket_handler).

-include("havel_logger.hrl").

-export([init/3]).
-export([websocket_init/3]).
-export([websocket_info/3]).
-export([websocket_handle/3]).
-export([websocket_terminate/3]).

-record(state, {
          auth_ok = false :: boolean(),
          shutdown_tref :: undefined | timer:tref()
         }).

init(_Type, Req, _Opt) ->
    {ok, Tref} = timer:send_after(60 * 1000, {sys, no_auth_shutdown}),
    {upgrade, protocol, cowboy_websocket, Req,
     #state{
        auth_ok = false,
        shutdown_tref = Tref
       }}.

websocket_init(_Type, Req, State) ->
    ?INFO_MSG("~p", [State]),
    {ok, Req, State}.

websocket_handle(Data, Req, State) ->
    ?INFO_MSG("~p", [Data]),
    {ok, Req, State}.

websocket_info({sys, no_auth_shutdown}, Req,
               State = #state{auth_ok = false}) ->
    {shutdown, Req, State};
websocket_info(Info, Req, State) ->
    ?INFO_MSG("~p", [Info]),
    {ok, Req, State}.

websocket_terminate(Reason, _Req, _State) ->
    ?INFO_MSG("~p", [Reason]),
    ok.
