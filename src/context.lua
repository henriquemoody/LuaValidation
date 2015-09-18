local context = {}

function context.merge_properties(context1, context2)
  for key, value in pairs(context2) do
    if not context1[key] then
      context1[key] = value
    end
  end
end

function context.new(rule, properties)
  local new_context = {}
  new_context.rule = rule
  new_context.children = {}
  new_context.result = true

  context.merge_properties(new_context, properties or {})

  function new_context:new_child(rule, properties)
    local child = context.new(rule, properties)

    context.merge_properties(child, self)

    child.parent = self
    table.insert(self.children, child)

    return child
  end

  function new_context:merge(properties)
    context.merge_properties(self, properties)
  end

  function new_context:apply_rule()
    self.rule.apply(self)
  end

  return new_context
end

return context
