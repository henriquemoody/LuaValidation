return function (key, rule, mandatory)
  if mandatory == nil then
    mandatory = true
  end

  return {
    messages = {
      affirmative = {
        std = "{{key}} must be defined",
      },
      negative = {
        std = "{{key}} must not be defined",
      },
    },

    apply = function (context)
      context.key = key

      if context.input[key] == nil then
        context.result = (mandatory == false)
        return
      end

      if not rule then
        context.result = true
        return
      end

      local child_context = context:new_child(rule)
      child_context.name = key
      child_context.input = context.input[key]
      child_context:apply_rule()

      context.result = child_context.result
    end,
  }
end
