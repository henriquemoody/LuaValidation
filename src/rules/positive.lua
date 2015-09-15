return function ()
  return {
    messages = {
      affirmative = {
        std = "{{placeholder}} must be positive",
      },
      negative = {
        std = "{{placeholder}} cannot be positive",
      },
    },

    apply = function (context)
      local number = tonumber(context.input)
      if not number then
        context.result = false
        return
      end

      context.result = (number > 0)
    end,
  }
end
