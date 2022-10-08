#!/usr/bin/env bash

luarocks make
luarocks pack op-sdk

ROCKSPEC="$(find . -name='*.rockspec')"

luarocks upload "$ROCKSPEC" --api-key="$LUAROCKS_API_KEY"
