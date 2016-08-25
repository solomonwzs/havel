-module(havel_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

-define(DISPATCH, [{'_', [{"/", havel_http_handler_index, []},
                          {"/auth/[...]", havel_http_handler_auth, []},
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
    cowboy:stop_listener(havel_http_listener),
    cowboy:stop_listener(havel_https_listener),
    ok.

start_http(Dispatch) ->
    {ok, HttpOpts} = application:get_env(havel, http_opts),
    Port = proplists:get_value(port, HttpOpts, 80),
    NAcceptors = proplists:get_value(n_acceptors, HttpOpts, 10),
    cowboy:start_http(havel_http_listener, NAcceptors,
                      [{port, Port}],
                      [{env, [{dispatch, Dispatch}]}]).

start_https(Dispatch) ->
    {ok, HttpsOpts} = application:get_env(havel, https_opts),
    Port = proplists:get_value(port, HttpsOpts, 443),
    KeyFile = proplists:get_value(keyfile, HttpsOpts),
    CertFile = proplists:get_value(certfile, HttpsOpts),
    NAcceptors = proplists:get_value(n_acceptors, HttpsOpts, 10),
    cowboy:start_https(havel_https_listener, NAcceptors,
                       [{port, Port}, {keyfile, KeyFile}, {certfile, CertFile}],
                       [{env, [{dispatch, Dispatch}]}]).
