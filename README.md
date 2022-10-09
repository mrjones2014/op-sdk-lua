# `op-sdk-lua`

A Lua 5.1+ SDK for 1Password using the 1Password CLI.

## Install

```
luarocks install op-sdk
```

## Usage

The SDK requires you initialize it with a backend (or use the default backend `require('op-sdk.backend.default)`; see [Default Backend](#default-backend)). A backend is just a Lua function that takes the full `op` command as a list of
arguments and handles executing the command and doing something with the results. The result is a table with functions nested in a structure mirroring the 1Password CLI command hierarchy,
with each command mapping to a function that optionally takes a list of arguments and passes them onto the backend. Any additional arguments are passed as additional arguments to the backend,
and any additional properties on the arguments table are preserved.

You can also specify a custom path to the `op` binary if not on your `$PATH`.

```lua
-- to use default backend, just
local op = require('op-sdk').init()

-- to use a custom backend
local my_backend = function(args)
  print(unpack(args))
end
local op = require('op-sdk').init(my_backend)

-- to use a custom binary path with default backend
local op = require('op-sdk').init(nil, '/path/to/op')

-- to use custom binary path with custom backend
local op = require('op-sdk').init(my_backend, '/path/to/op')

-- example of passing a custom argument, with an extra callback argument
local my_backend = function(args, callback)
  if args.async then
    -- handle asynchronously
    -- then call the callback function
  else
    -- handle synchronously
  end
end
local op = require('op-sdk').init(my_backend)
op.item({ async = true }, function(results)
  -- do stuff with the results,
  -- this callback is called asynchronously
end)
```

### Default Backend

The default backend is available at `require('op-sdk.backend.default')`. It is implemented using `io.popen`
and creates the following API signature:

```lua
function(args:string[]): stdout:string[], stderr:string[], exit_code:int
```

Example usage:

```lua
local op = require('op-sdk').init()
local stdout, stderr, exit_code = op.account.get({ '--format', 'json' })
if exit_code == 0 then
  -- do stuff with stdout,
  -- which is a list of lines
else
  -- do stuff with stderr,
  -- which is a list of lines
end
```

## Types

A type definition of the CLI table is available at [src/op-sdk/types.lua](./src/op-sdk/types.lua).
