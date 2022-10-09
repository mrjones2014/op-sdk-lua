#!/usr/bin/env bash

NEW_VERSION="$1"

if [[ "$NEW_VERSION" = "" ]]; then
  echo "New version is required as an argument"
fi

rm "*.rock"

OLD_ROCKSPEC="$(find . -name '*.rockspec')"

luarocks --lua-version=5.1 make --pack-binary-rock
luarocks --lua-version=5.1 pack op-sdk

luarocks new_version --tag="$NEW_VERSION"

rm "$OLD_ROCKSPEC"

git add .
git commit -m "prep v$NEW_VERSION"
git tag "v$NEW_VERSION"
git push
git push --tags

ROCKSPEC="$(find . -name '*.rockspec')"

luarocks --lua-version=5.1 upload "$ROCKSPEC" --api-key="$LUAROCKS_API_KEY"
