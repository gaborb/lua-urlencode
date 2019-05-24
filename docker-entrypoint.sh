#!/bin/sh
eval "$(luarocks path --bin)"
exec "$@"