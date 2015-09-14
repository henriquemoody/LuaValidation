return function ()
  return function (context)
    context.result = context.input ~= nil
  end
end
