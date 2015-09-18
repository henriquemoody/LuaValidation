return function (result)
  return {
    messages = {
      affirmative = {
        standard = "{{placeholder}} with result {{result}} in affirmative mode",
      },
      negative = {
        standard = "{{placeholder}} with result {{result}} in negative mode",
      },
    },
    apply = function (context)
      context.result = result
    end,
  }
end
