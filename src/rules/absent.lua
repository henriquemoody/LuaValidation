return function ()
  return {
    messages = {
      affirmative = {
        standard = "{{placeholder}} must be defined",
      },
      negative = {
        standard = "{{placeholder}} cannot be defined",
      },
    },
    apply = function (context)
      context.result = context.input == nil
    end,
  }
end
