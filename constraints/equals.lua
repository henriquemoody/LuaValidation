return function (expected)
  return {
    messages = {},
    apply = function (context)
      context.expected = expected
      context.result = context.input == expected
    end,
  }
end
