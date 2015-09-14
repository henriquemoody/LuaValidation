return function (constraint)
  local constraints = {}
  return {
      messages = {},
      addConstraint = function (instance, constraint)
        table.insert(constraints, constraint)

        return instance
      end,
      getConstraints  = function ()
        return constraints
      end,
      apply = function (context)
        context.result = true

        if #constraints == 0 then
            return
        end

        for _, constraint in pairs(constraints) do
          local childContext = context:newChild(constraint)
          childContext:applyConstraint()

          context.result = context.result and childContext.result
        end
      end,
  }
end
