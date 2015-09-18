return function ()
  return {
    messages = {
      affirmative = {
        standard = "{{placeholder}} must be a number",
      },
      negative = {
        standard = "{{placeholder}} cannot be a number",
      },
    },
    apply = function (context)
      context.result = type(context.input) == "number"
    end,
  }
end
