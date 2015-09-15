return function (key, constraint, mandatory)
  if mandatory == nil then
    mandatory = true
  end

  return {
    messages = {
      affirmative = {
        std = "{{key}} must be present",
      },
      negative = {
        std = "{{key}} must not be present",
      },
    },

    apply = function (context)
      context.name = key

      if context.input[key] == nil then
        context.result = (mandatory == false)
        return
      end

      if not constraint then
        context.result = true
        return
      end

      local child_context = context:new_child(constraint, {name = key, input = context.input[key]})
      child_context:apply_constraint()

      context.result = child_context.result
    end,
  }
end
