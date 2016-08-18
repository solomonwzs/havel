-module(havel_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

-define(DISPATCH, [{'_', [{"/", havel_http_handler_index, []},
                          {"/ws", havel_ws_handler, []},
                          {"/h/[...]", cowboy_static, {priv_dir, havel, "http"}}
                         ]}
    ]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile(?DISPATCH),
    start_http(Dispatch),
    start_https(Dispatch),
    havel_sup:start_link().

stop(_State) ->
    ok.

start_http(Dispatch) ->
    {ok, HttpOpts} = application:get_env(havel, http_opts),
    Port = proplists:get_value(port, HttpOpts, 80),
    cowboy:start_http(havel_http_listener, 100,
                      [{port, Port}],
                      [{env, [{dispatch, Dispatch}]}]).

start_https(Dispatch) ->
    {ok, HttpsOpts} = application:get_env(havel, https_opts),
    Port = proplists:get_value(port, HttpsOpts, 443),
    KeyFile = proplists:get_value(keyfile, HttpsOpts),
    CertFile = proplists:get_value(certfile, HttpsOpts),
    cowboy:start_https(havel_https_listener, 100,
                       [{port, Port}, {keyfile, KeyFile}, {certfile, CertFile}],
                       [{env, [{dispatch, Dispatch}]}]).
