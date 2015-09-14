return function (result)
  return {
    messages = {
      affirmative = {
        std = "{{placeholder}} have to be {{result}}",
      },
      negative = {
        std = "{{placeholder}} have not to be {{result}}",
      },
    },
    apply = function (context)
      context.result = result
    end,
  }
end
