-module(havel_web_handler_index).
-behaviour(cowboy_http_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

-include("havel_logger.hrl").

init({tcp, http}, Req, Opts) ->
    {ok, Req, Opts}.

handle(Req, State) ->
    {ok, Req2} = cowboy_req:reply(200,
                                  [{<<"content-type">>, <<"text/plain">>}],
                                  <<"Hello Havel!">>,
                                  Req),
    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
    ok.
