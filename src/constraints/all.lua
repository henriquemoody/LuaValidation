return function (...)
  local constraints = {...}
  return {
    messages = {
      affirmative = {
        std = "These constraints must pass for {{placeholder}}",
        all = "All constraints must pass for {{placeholder}}",
      },
      negative = {
        all = "All constraints must not pass for {{placeholder}}",
      },
    },

    add_constraint = function (instance, constraint)
      table.insert(constraints, constraint)
      return instance
    end,
    get_constraints  = function ()
      return constraints
    end,
    apply = function (context)
      local failures = 0

      context.result = true

      if #constraints == 0 then
        return
      end

      for _, constraint in pairs(constraints) do
        local child_context = context:new_child(constraint)
        child_context:apply_constraint()

        if child_context.result == false then
          failures = (failures + 1)
          context.result = false
        end
      end

      if failures == #constraints then
        context.template = "all"
      end
    end,
  }
end
