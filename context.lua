local module = {new = nil}

module.new = function (input, properties)
  local context = properties or {}
  context.input = input
  context.children = {}
  context.newChild = function (instance, input, properties)
    local child = module.new(input, properties)

    child.parent = instance
    table.insert(instance.children, child)

    return child
  end

  return context
end

return module
