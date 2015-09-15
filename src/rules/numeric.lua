return function ()
  return {
    messages = {
      affirmative = {
        std = "{{placeholder}} must be numeric",
      },
      negative = {
        std = "{{placeholder}} cannot be numeric",
      },
    },

    apply = function (context)
      context.result = (tonumber(context.input) ~= nil)
    end,
  }
end
