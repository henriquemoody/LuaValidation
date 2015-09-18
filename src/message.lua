local message = {}

function message.build(context)
  local messages = context.rule.messages
  local mode = context.mode or "affirmative"
  local template = context.template or "std"
  local parent = context.parent
  local message = messages[mode][template]

  if context.message
      and (not parent
        or (parent and not parent._message)
        or (parent and parent._message and parent.message ~= context.message)) then
    message = context.message
  end

  context.placeholder = context.placeholder or context.name or tostring(context.input)

  if context.translator then
    message = context.translator(message)
  end

  for property in string.gmatch(message, "{{(%a+)}}") do
    message = string.gsub(
      message,
      "{{" .. property .. "}}",
      '"' .. tostring(context[property]) .. '"'
    )
  end

  context._message = message

  return message
end

function message.get_messages(context, level)
  local messages = {}

  while (#context.children == 1 and level > 1) do
    context = context.children[1]
  end

  if (context.mode == "negative" or context.result == false) then
    table.insert(messages, {level = level, content = message.build(context)})
  end

  for index=1, #context.children do
    local childConstraint = context.children[index]
    local childLevel = (level + 1)
    local childMessages = message.get_messages(childConstraint, childLevel)
    for _, message in pairs(childMessages) do
      table.insert(messages, message)
    end
  end

  return messages
end

function message.new(context)
  return {
    get_full = function ()
      local messages = {}
      for _, message in pairs(message.get_messages(context, 1)) do
        local prefix = ""

        if message.level > 1 then
          prefix = string.rep(" ", (message.level - 1)) .. "- "
        end

        table.insert(messages, prefix .. message.content)
      end

      return table.concat(messages, "\n")
    end,

    get_single = function ()
      local current = context
      while #current.children == 1 do
          current = current.children[1]
      end

      return message.build(current)
    end
  }
end

return message
