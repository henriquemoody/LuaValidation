local module = {new = nil}

module.new = function (rule, properties)
  local context = {}
  context.rule = rule
  context.children = {}
  context.result = true

  properties = properties or {}
  for key, value in pairs(properties) do
    context[key] = value
  end

  context.new_child = function (self, rule, properties)
    local child = module.new(rule, properties)

    for key, value in pairs(self) do
      if not child[key] then
        child[key] = value
      end
    end

    child.parent = self
    table.insert(self.children, child)

    return child
  end

  context.apply_rule = function (self)
    self.rule.apply(self)
  end

  return context
end

return module
