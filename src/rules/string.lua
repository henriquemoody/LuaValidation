return function ()
  return {
    messages = {
      affirmative = {
        std = "{{placeholder}} must be a string",
      },
      negative = {
        std = "{{placeholder}} cannot be a string",
      },
    },
    apply = function (context)
      context.result = type(context.input) == "string"
    end,
  }
end
