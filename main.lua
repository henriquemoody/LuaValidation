local module = {}

local metatable = {}

local function __index(instance, key)
  instance._last = require("constraints." .. key) -- Use pcall to other prefices

  return instance
end

local function __call(instance, ...)
  instance:add_constraint(instance._last(...))

  return instance
end

module = require("constraints.all_of")()
module.display = print
module.last_display = module.display

module.set_display = function (callback)
  module.last_display = module.display
  module.display = callback
end

module.restoreDisplay = function (callback)
  module.display = module.last_display or print
  module.last_display = nil
end

module.assert = function (instance, module)
  instance.display("assert message")
end

module.check = function (instance, module)
  instance.display("check message")
end

module.validate = function (instance, input, properties)
  local context
  local context_properties

  context_properties = properties or {}
  context_properties.input = input

  context = require("context").new(instance, context_properties)
  context:apply_constraint()

  return context.result
end

metatable.__index = __index
metatable.__call = __call

metatable.new = function ()
  local new_table = {}
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
