local context = {}

function context.new(rule, properties)
  local new_context = {}
  new_context.rule = rule
  new_context.children = {}
  new_context.result = true

  properties = properties or {}
  for key, value in pairs(properties) do
    new_context[key] = value
  end

  function new_context:new_child(rule, properties)
    local child = context.new(rule, properties)

    for key, value in pairs(self) do
      if not child[key] then
        child[key] = value
      end
    end

    child.parent = self
    table.insert(self.children, child)

    return child
  end

  function new_context:apply_rule()
    self.rule.apply(self)
  end

  return new_context
end

return context
