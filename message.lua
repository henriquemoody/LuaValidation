return function (context)
  return {
    get_full = function (instance)

    end,
    get = function (instance)
      local current = context
      while #current.children == 1 do
          current = current.children[1]
      end

      return instance.build(current)
    end,
    build = function (current)
      local messages = current.constraint.messages
      local mode = current.mode or "affirmative"
      local template = current.template or "std"
      local message = current.message or messages[mode][template]
      local steps = {}

      current.placeholder = current.placeholder or current.name or tostring(current.input)

      for property in string.gmatch(message, "{{(%a+)}}") do
        if current[property] then
          message = string.gsub(
            message,
            "{{" .. property .. "}}",
            '"' .. current[property] .. '"'
          )
        end
      end

      return message
    end
  }
end
