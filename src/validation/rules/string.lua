return function ()
  return {
    messages = {
      affirmative = {
        standard = "{{placeholder}} must be a string",
      },
      negative = {
        standard = "{{placeholder}} cannot be a string",
      },
    },
    apply = function (context)
      context.result = type(context.input) == "string"
    end,
  }
end
