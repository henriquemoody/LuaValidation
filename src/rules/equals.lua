return function (expected)
  return {
    messages = {
      affirmative = {
        std = "{{placeholder}} must be equal to {{expected}}",
      },
      negative = {
        std = "{{placeholder}} cannot be equal to {{expected}}",
      },
    },

    apply = function (context)
      context.expected = expected
      context.result = context.input == expected
    end,
  }
end
