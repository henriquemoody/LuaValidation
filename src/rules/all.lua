return function (...)
  local rules = {...}
  return {
    messages = {
      affirmative = {
        std = "Some rules must pass for {{placeholder}}",
        all = "All rules must pass for {{placeholder}}",
      },
      negative = {
        std = "Some rules cannot pass for {{placeholder}}",
        all = "All rules cannot pass for {{placeholder}}",
      },
    },

    add_rule = function (instance, rule)
      table.insert(rules, rule)
      return instance
    end,
    get_rules  = function ()
      return rules
    end,
    apply = function (context)
      local failures = 0

      context.result = true

      if #rules == 0 then
        return
      end

      for _, rule in pairs(rules) do
        local child_context = context:new_child(rule)
        child_context:apply_rule()

        if child_context.result == false then
          failures = (failures + 1)
          context.result = false
        end
      end

      if failures == #rules then
        context.template = "all"
      end
    end,
  }
end
