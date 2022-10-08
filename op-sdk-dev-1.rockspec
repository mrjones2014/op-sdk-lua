rockspec_format = '3.0'
package = 'op-sdk'
version = 'dev-1'
source = {
  url = 'git+ssh://git@github.com/mrjones2014/op-lua-sdk.git',
}
description = {
  homepage = 'https://github.com/op-lua-sdk#README.md',
  license = 'MIT License',
  summary = 'Lua bindings to the 1Password CLI, with a configurable process executor backend.',
}
build = {
  type = 'builtin',
  modules = {
    ['op-sdk'] = './src/op-sdk.lua',
    ['op-sdk.types'] = './src/op-sdk/types.lua',
    ['op-sdk.backend.default'] = './src/op-sdk/backend/default.lua',
  },
}
test = {
  type = 'busted',
}
