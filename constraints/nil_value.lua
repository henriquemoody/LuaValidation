return function ()
  return {
    messages = {
      affirmative = {
        std = "{{placeholder}} must be `nil`",
      },
      negative = {
        std = "{{placeholder}} must not be `nil`",
      },
    },
    apply = function (context)
      context.result = context.input == nil
    end,
  }
end
