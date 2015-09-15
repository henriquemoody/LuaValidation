return function ()
  return {
    messages = {
      affirmative = {
        std = "{{placeholder}} must be defined",
      },
      negative = {
        std = "{{placeholder}} cannot be defined",
      },
    },
    apply = function (context)
      context.result = context.input == nil
    end,
  }
end
