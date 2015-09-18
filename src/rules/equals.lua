return function (expected)
  return {
    messages = {
      affirmative = {
        standard = "{{placeholder}} must be equal to {{expected}}",
      },
      negative = {
        standard = "{{placeholder}} cannot be equal to {{expected}}",
      },
    },

    apply = function (context)
      context.expected = expected
      context.result = context.input == expected
    end,
  }
end
