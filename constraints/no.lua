return function (constraint)
  return {
    messages = {},
    apply = function (context)
      local child_context = context:new_child(constraint)
      child_context:apply_constraint()

      context.mode = "negative"
      context.result = (child_context.result == false)
    end,
  }
end
