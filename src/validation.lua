local all = require("rules.all")
local message = require("message")
local metatable = {}
local module = {}

local function __index(instance, key)
  instance._last = require("rules." .. key) -- Use pcall to other prefices

  return instance
end

local function __call(instance, ...)
  instance:add_rule(instance._last(...))

  return instance
end

module.messager = error
module.last_messager = module.messager

module.set_messager = function (callback)
  module.last_messager = module.messager
  module.messager = callback
end

module.restoreDisplay = function (callback)
  module.messager = module.last_messager or error
  module.last_messager = nil
end

module.assert = function (instance, input, properties)
  local context
  local context_properties

  context_properties = properties or {}
  context_properties.input = input

  context = require("context").new(instance, context_properties)
  context:apply_rule()

  instance.messager(message(context):get_full())
end

module.check = function (instance, input, properties)
  local context
  local context_properties

  context_properties = properties or {}
  context_properties.input = input

  context = require("context").new(instance, context_properties)

  for _, rule in pairs(instance.get_rules()) do
    local child_context = context:new_child(rule)
    child_context:apply_rule()

    if not child_context.result then
      local child_message = message(child_context)

      instance.messager(child_message:get_single())
      break
    end
  end
end

module.validate = function (instance, input, properties)
  local context
  local context_properties

  context_properties = properties or {}
  context_properties.input = input

  context = require("context").new(instance, context_properties)
  context:apply_rule()

  return context.result
end

metatable.__index = __index
metatable.__call = __call

metatable.new = function ()
  local new_table = all()
  for key, value in pairs(module) do
    new_table[key] = value
  end

  new_table._last = nil

  return setmetatable(new_table, metatable)
end

return setmetatable(
  module,
  {
    __index = function (instance, key)
      local new_table = metatable.new()
      __index(new_table, key)

      return new_table
    end
  }
)
