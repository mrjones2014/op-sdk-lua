describe('op-sdk', function()
  local function test_backend(on_done)
    return function(args)
      on_done(args)
    end
  end

  it('should wire up top-level commands and call backend with correct arguments', function()
    local on_done = function(args)
      assert.is.equal(#args, 2)
      assert.is.equal(args[1], 'op')
      assert.is.equal(args[2], 'signin')
    end
    local op = require('op-sdk').init(test_backend(on_done))
    op.signin()
  end)

  it('should wire up nested commands and call backend with correct arguments', function()
    local function on_done(args)
      assert.is.equal(#args, 3)
      assert.is.equal(args[1], 'op')
      assert.is.equal(args[2], 'account')
      assert.is.equal(args[3], 'list')
    end
    local op = require('op-sdk').init(test_backend(on_done))
    op.account.list()
  end)

  it('should wire up deeply nested commands and call backend with correct arguments', function()
    local function on_done(args)
      assert.is.equal(#args, 6)
      assert.is.equal(args[1], 'op')
      assert.is.equal(args[2], 'connect')
      assert.is.equal(args[3], 'server')
      assert.is.equal(args[4], 'create')
      assert.is.equal(args[5], '--format')
      assert.is.equal(args[6], 'json')
    end
    local op = require('op-sdk').init(test_backend(on_done))
    op.connect.server.create({ '--format', 'json' })
  end)

  it('should pass on arguments passed to the API function to the backend', function()
    local test_uuid = 'XXXXXXXXXXXXXXX'
    local function on_done(args)
      assert.is.equal(#args, 6)
      assert.is.equal(args[1], 'op')
      assert.is.equal(args[2], 'item')
      assert.is.equal(args[3], 'get')
      assert.is.equal(args[4], test_uuid)
      assert.is.equal(args[5], '--format')
      assert.is.equal(args[6], 'json')
    end
    local op = require('op-sdk').init(test_backend(on_done))
    op.item.get({ test_uuid, '--format', 'json' })
  end)

  it('should allow configuring the binary path', function()
    local test_op_path = '/path/to/op'
    local function on_done(args)
      assert.is.equal(#args, 2)
      assert.is.equal(args[1], test_op_path)
      assert.is.equal(args[2], 'signin')
    end
    local op = require('op-sdk').init(test_backend(on_done), test_op_path)
    op.signin()
  end)
end)
