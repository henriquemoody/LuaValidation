return function ()
  return {
    messages = {
      affirmative = {
        standard = "{{placeholder}} must be numeric",
      },
      negative = {
        standard = "{{placeholder}} cannot be numeric",
      },
    },

    apply = function (context)
      context.result = (tonumber(context.input) ~= nil)
    end,
  }
end
