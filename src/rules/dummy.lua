return function (result)
  return {
    messages = {
      affirmative = {
        std = "{{placeholder}} with result {{result}} in affirmative mode",
      },
      negative = {
        std = "{{placeholder}} with result {{result}} in negative mode",
      },
    },
    apply = function (context)
      context.result = result
    end,
  }
end
