local all = require("validation.rules.all")
local context = require("validation.context")
local default_properties = {}
local last_messager = nil
local message = require("validation.message")
local messager = error
local validation = {}

function validation.set_messager(callback)
  last_messager = messager
  messager = callback
end

function validation.restore_messager(callback)
  messager = last_messager or error
  last_messager = nil
end

function validation.set_defaults(properties)
  for key, value in pairs(properties) do
    default_properties[key] = value
  end
end

function validation:assert(input, properties)
  local chain_context

  chain_context = context.new(self, {input = input})
  chain_context:merge(properties or {})
  chain_context:merge(default_properties)
  chain_context:apply_rule()

  if not chain_context.result then
    local context_message = message.new(chain_context)

    messager(context_message.get_full())
  end
end

function validation:check(input, properties)
  local chain_context

  chain_context = context.new(self, {input = input})
  chain_context:merge(properties or {})
  chain_context:merge(default_properties)

  for _, rule in pairs(self.get_rules()) do
    local child_context = chain_context:new_child(rule)
    child_context:apply_rule()

    if not child_context.result then
      local child_message = message.new(child_context)

      messager(child_message.get_single())
      break
    end
  end
end

function validation:validate(input, properties)
  local chain_context

  chain_context = context.new(self, {input = input})
  chain_context:merge(properties or {})
  chain_context:merge(default_properties)
  chain_context:apply_rule()

  return chain_context.result
end

function validation.new()
  local new_validation = all()
  local metatable = {}

  for key, value in pairs(validation) do
    new_validation[key] = value
  end

  function metatable:__index(key)
    self._last = require("validation.rules." .. key) -- Use pcall to other prefices

    return self
  end

  function metatable:__call(...)
    self:add_rule(self._last(...))

    return self
  end

  return setmetatable(new_validation, metatable)
end

return setmetatable(
  validation,
  {
    __index = function (self, key)
      local new_validation = validation.new()

      return new_validation[key]
    end
  }
)
