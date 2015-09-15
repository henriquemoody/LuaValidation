return function (rule)
  return {
    messages = {},
    apply = function (context)
      local child_context = context:new_child(rule)
      if child_context.mode == "affirmative" then
        child_context.mode = "negative"
      elseif child_context.mode == "negative" then
        child_context.mode = "affirmative"
      else
        child_context.mode = "negative"
      end
      child_context:apply_rule()
      child_context.result = (child_context.result == false)

      context.result = child_context.result
    end,
  }
end
