return function (constraint)
  return {
    messages = {},
    apply = function (context)
      local child_context = context:new_child(constraint)
      if child_context.mode == "affirmative" then
        child_context.mode = "negative"
      elseif child_context.mode == "negative" then
        child_context.mode = "affirmative"
      else
        child_context.mode = "negative"
      end
      child_context:apply_constraint()
      child_context.result = (child_context.result == false)

      context.result = child_context.result
    end,
  }
end
