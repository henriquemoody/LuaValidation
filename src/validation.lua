local all = require("rules.all")
local message = require("message")
local validation = {
  _last = nil,
  messager = error,
  last_messager = nil,
}

function validation.set_messager(callback)
  validation.last_messager = validation.messager
  validation.messager = callback
end

function validation.restore_messager(callback)
  validation.messager = validation.last_messager or error
  validation.last_messager = nil
end

function validation:assert(input, properties)
  local context
  local context_properties
  local context_message

  context_properties = properties or {}
  context_properties.input = input

  context = require("context").new(self, context_properties)
  context:apply_rule()

  if not context.result then
    context_message = message.new(context)

    self.messager(context_message.get_full())
  end
end

function validation:check(input, properties)
  local context
  local context_properties

  context_properties = properties or {}
  context_properties.input = input

  context = require("context").new(self, context_properties)

  for _, rule in pairs(self.get_rules()) do
    local child_context = context:new_child(rule)
    child_context:apply_rule()

    if not child_context.result then
      local child_message = message.new(child_context)

      self.messager(child_message.get_single())
      break
    end
  end
end

function validation:validate(input, properties)
  local context
  local context_properties

  context_properties = properties or {}
  context_properties.input = input

  context = require("context").new(self, context_properties)
  context:apply_rule()

  return context.result
end

function validation.new()
  local new_validation = all()
  local metatable = {}

  for key, value in pairs(validation) do
    new_validation[key] = value
  end

  function metatable:__index(key)
    self._last = require("rules." .. key) -- Use pcall to other prefices

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
