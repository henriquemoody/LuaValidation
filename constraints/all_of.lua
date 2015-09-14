return function (...)
  local constraints = {...}
  return {
    messages = {},
    add_constraint = function (instance, constraint)
      table.insert(constraints, constraint)
      return instance
    end,
    get_constraints  = function ()
      return constraints
    end,
    apply = function (context)
      context.result = true

      if #constraints == 0 then
        return
      end

      for _, constraint in pairs(constraints) do
        local child_context = context:new_child(constraint)
        child_context:apply_constraint()

        if child_context.result == false then
          context.result = false
        end
      end
    end,
  }
end
