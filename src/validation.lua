local all = require("rules.all")
local message = require("message")
local metatable = {}
local validation = {
  messager = error,
  last_messager = nil,
}

function validation.set_messager(callback)
  validation.last_messager = validation.messager
  validation.messager = callback
end

function validation.restoreDisplay(callback)
  validation.messager = validation.last_messager or error
  validation.last_messager = nil
end

function validation:assert(input, properties)
  local context
  local context_properties

  context_properties = properties or {}
  context_properties.input = input

  context = require("context").new(self, context_properties)
  context:apply_rule()

  self.messager(message(context):get_full())
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
      local child_message = message(child_context)

      self.messager(child_message:get_single())
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

function metatable:__index(key)
  self._last = require("rules." .. key) -- Use pcall to other prefices

  return self
end

function metatable:__call(...)
  self:add_rule(self._last(...))

  return self
end

function metatable.new()
  local new_table = all()
  for key, value in pairs(validation) do
    new_table[key] = value
  end

  new_table._last = nil

  return setmetatable(new_table, metatable)
end

return setmetatable(
  validation,
  {
    __index = function (self, key)
      local new_table = metatable.new()
      metatable.__index(new_table, key)

      return new_table
    end
  }
)
