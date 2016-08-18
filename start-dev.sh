#!/bin/bash

EXEC="bash -c"
DEV_PATH="$(pwd)/dev"
ERL="erl"

SPOOL_DIR="$DEV_PATH/var/db/mnesia"
if [[ ! -d "$SPOOL_DIR" ]]; then
    mkdir -p "$SPOOL_DIR"
fi

BEAM_PATH="-pa $(pwd)/ebin $(pwd)/deps/*/ebin"
MNESIA_OPTS="-mnesia dir \"\\\"$SPOOL_DIR\\\"\""
ERLANG_OPTS="+K true -smp auto +P 250000"

CMD="$ERL -sname havel-dev \
    $BEAM_PATH \
    $MNESIA_OPTS \
    $ERLANG_OPTS \
    -config dev/etc/havel.config \
    -s reloader \
    -s havel"
$EXEC "$CMD"
