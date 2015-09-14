return function ()
  return {
      messages = {},
      apply = function (context)
        context.result = context.input ~= nil
      end,
  }
end
