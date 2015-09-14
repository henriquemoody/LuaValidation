return function (expected)
  return function (context)
    context.result = context.input == expected
  end
end
