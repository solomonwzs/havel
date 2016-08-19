-module(havel_http_handler_auth).
-behaviour(cowboy_http_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

-include("havel_logger.hrl").

init({Type, http}, Req, Opts) when Type =:= tcp orelse Type =:=ssl ->
    ?INFO_MSG("hi", []),
    {ok, Req, Opts}.

handle(Req, State) ->
    {R, _} = cowboy_req:path_info(Req),
    ?INFO_MSG("~p", [R]),
    {ok, Req2} = cowboy_req:reply(200,
                                  [{<<"content-type">>, <<"text/plain">>}],
                                  <<"Hello Havel!">>,
                                  Req),
    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
    ok.
