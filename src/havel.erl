-module(havel).

-export([start/0, stop/0, restart/0]).

start() ->
    lager:start(),
    application:start(ranch),
    application:start(crypto),
    application:start(cowlib),
    application:start(cowboy),
    application:start(havel).

stop() ->
    application:stop(havel).

restart() ->
    stop(),
    start().
