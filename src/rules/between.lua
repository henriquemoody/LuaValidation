return function (minimum, maximum)
  return {
    messages = {
      affirmative = {
        std = "{{placeholder}} must be between {{minimum}} and {{maximum}}",
        number = "{{placeholder}} must be a number to be compared to {{minimum}} and {{maximum}}",
      },
      negative = {
        std = "{{placeholder}} cannot be between {{minimum}} and {{maximum}}",
        number = "{{placeholder}} cannot be a number to be compared to {{minimum}} and {{maximum}}",
      },
    },

    apply = function (context)
      context.minimum = minimum
      context.maximum = maximum

      local number = tonumber(context.input)

      if not number then
        context.result = false
        context.template = "number"
        return
      end

      context.result = (number >= minimum and number <= maximum)
    end,
  }
end
