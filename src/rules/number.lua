return function ()
  return {
    messages = {
      affirmative = {
        std = "{{placeholder}} must be a number",
      },
      negative = {
        std = "{{placeholder}} cannot be a number",
      },
    },
    apply = function (context)
      context.result = type(context.input) == "number"
    end,
  }
end
