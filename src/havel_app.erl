-module(havel_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

-define(DISPATCH, [{'_', [{"/", havel_web_handler_index, []}]}
    ]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile(?DISPATCH),
    cowboy:start_http(havel_http_listener, 100,
        [{port, 9091}],
        [{env, [{dispatch, Dispatch}]}]),
    havel_sup:start_link().

stop(_State) ->
    ok.
