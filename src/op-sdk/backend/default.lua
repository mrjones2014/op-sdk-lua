local function shellescape(args)
  local ret = {}
  for _, arg in pairs(args) do
    local arg_str = tostring(arg)
    if arg_str:match('[^A-Za-z0-9_/:=-]') then
      arg_str = "'" .. arg_str:gsub("'", "'\\''") .. "'"
    end
    table.insert(ret, arg_str)
  end
  return table.concat(ret, ' ')
end

local function trim(s)
  return s:match('^%s*(.*%S)') or ''
end

local function map(predicate, list)
  local result = {}
  for _, value in ipairs(list) do
    table.insert(result, predicate(value))
  end
  return result
end

local function filter(predicate, list)
  local result = {}
  for _, value in pairs(list) do
    if predicate(value) then
      table.insert(result, value)
    end
  end

  return result
end

local function split_to_lines(output)
  output = output or ''
  local lines = {}
  for s in output:gmatch('[^\r\n]+') do
    table.insert(lines, s)
  end

  lines = map(trim, lines)
  lines = filter(function(str)
    return #str > 0
  end, lines)

  return lines or {}
end

return function(args)
  local cmd_str = shellescape(args)
  local proc = io.popen(cmd_str, 'r')
  if proc == nil then
    error('Failed to start external job.')
    return
  end
  local output = proc:read('*a')
  local _, exit, status = proc:close()
  status = exit == 'exit' and status or 127

  -- non-zero, output in stderr position
  if status ~= 0 then
    return {}, split_to_lines(output), status
  else
    -- zero exit code, output in stdout position
    return split_to_lines(output), {}, status
  end
end
