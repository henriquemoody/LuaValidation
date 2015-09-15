return function (expected)
  return {
    messages = {
      affirmative = {
        std = "{{placeholder}} must be equals to {{expected}}",
      },
      negative = {
        std = "{{placeholder}} must not be equals to {{expected}}",
      },
    },

    apply = function (context)
      context.expected = expected
      context.result = context.input == expected
    end,
  }
end
