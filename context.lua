local module = {new = nil}

module.new = function (constraint, properties)
  local context = {}
  context.constraint = constraint
  context.children = {}
  context.result = true

  properties = properties or {}
  for key, value in pairs(properties) do
    context[key] = value
  end

  context.new_child = function (instance, constraint, properties)
    local child = module.new(constraint, properties)

    for key, value in pairs(instance) do
      if not child[key] then
        child[key] = value
      end
    end

    child.parent = instance
    table.insert(instance.children, child)

    return child
  end

  context.apply_constraint = function (instance)
    instance.constraint.apply(instance)
  end

  return context
end

return module
