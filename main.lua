local module = {}
local metatable = {}

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
  properties.result = true

  local context = require("context").new(input, properties)

  for _, childConstraint in pairs(instance._constraints) do
    local childContext = context:newChild(input, properties)
    childConstraint(childContext)

    context.result = context.result and childContext.result
  end

  return context.result
end

module.__index = function (instance, key)
  instance._last = require("constraints." .. key) -- Use pcall to other prefices

  return instance
end

module.__call = function (instance, ...)
  table.insert(instance._constraints, instance._last(...))

  return instance
end

metatable.__index = module.__index

metatable.__call = module.__call

metatable.new = function ()
  local newTable = {}
  for key, value in pairs(module) do
    newTable[key] = value
  end

  newTable._constraints = {}
  newTable._last = nil

  return setmetatable(newTable, metatable)
end

return setmetatable(
  module,
  {
    key = nil,

    __index = function (instance, key)
      instance.key = key

      return instance
    end,

    __call = function (instance, ...)
      local newTable = metatable.new()

      newTable.__index(newTable, instance.key)
      newTable.__call(newTable, ...)

      return newTable
    end
  }
)
