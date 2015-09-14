return function (expected)
  return {
      messages = {},
      apply = function (context)
        context.result = context.input == expected
      end,
  }
end
