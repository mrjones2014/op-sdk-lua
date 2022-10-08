#!/usr/bin/env bash

luarocks --lua-version=5.1 make
luarocks --lua-version=5.1 pack op-sdk

ROCKSPEC="$(find . -name '*.rockspec')"

luarocks --lua-version=5.1 upload "$ROCKSPEC" --api-key="$LUAROCKS_API_KEY"
