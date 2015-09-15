return function (context)
  local function build(current)
    local messages = current.rule.messages
    local mode = current.mode or "affirmative"
    local template = current.template or "std"
    local message = current.message or messages[mode][template]

    current.placeholder = current.placeholder or current.name or tostring(current.input)

    if current.translator then
      message = current.translator(message)
    end

    for property in string.gmatch(message, "{{(%a+)}}") do
      message = string.gsub(
        message,
        "{{" .. property .. "}}",
        '"' .. tostring(current[property]) .. '"'
      )
    end

    return message
  end

  local function get_messages(current, level)
    local messages = {}

    while (#current.children == 1 and level > 0) do
      current = current.children[1]
    end

    if (current.mode == "negative" or current.result == false) then
      table.insert(messages, {level = level, content = build(current)})
    end

    for index=1, #current.children do
      local childConstraint = current.children[index]
      local childLevel = (level + 1)
      local childMessages = get_messages(childConstraint, childLevel)
      for _, message in pairs(childMessages) do
        table.insert(messages, message)
      end
    end

    return messages
  end

  return {
    get_full = function (instance)
      local messages = {}
      for _, message in pairs(get_messages(context, 0)) do
        local prefix = ""

        if message.level > 0 then
          prefix = string.rep(" ", message.level) .. "- "
        end

        table.insert(messages, prefix .. message.content)
      end

      return table.concat(messages, "\n")
    end,

    get_single = function (instance)
      local current = context
      while #current.children == 1 do
          current = current.children[1]
      end

      return build(current)
    end
  }
end
