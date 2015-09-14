local module = {}
local metatable = {}

module = require("constraints.allOf")()
module.display = print
module.lastDisplay = module.display

module.setDisplay = function (callback)
  module.lastDisplay = module.display
  module.display = callback
end

module.restoreDisplay = function (callback)
  module.display = module.lastDisplay or print
  module.lastDisplay = nil
end

module.assert = function (instance, module)
  instance.display("assert message")
end

module.check = function (instance, module)
  instance.display("check message")
end

module.validate = function (instance, input, properties)
  properties = properties or {}
  properties.input = input

  local context = require("context").new(instance, properties)
  context:applyConstraint()

  return context.result
end

module.__index = function (instance, key)
  instance._last = require("constraints." .. key) -- Use pcall to other prefices

  return instance
end

module.__call = function (instance, ...)
  instance:addConstraint(instance._last(...))

  return instance
end

metatable.__index = module.__index

metatable.__call = module.__call

metatable.new = function ()
  local newTable = {}
  for key, value in pairs(module) do
    newTable[key] = value
  end

  newTable._last = nil

  return setmetatable(newTable, metatable)
end

return setmetatable(
  module,
  {
    __index = function (instance, key)
      local newTable = metatable.new()
      newTable.__index(newTable, key)

      return newTable
    end
  }
)
