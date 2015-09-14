return function (result)
  return {
    apply = function (context)
      context.result = result
    end,
  }
end
