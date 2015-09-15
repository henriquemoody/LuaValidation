package = "validation"
version = "0.1-1"

build = {
  type = "builtin",
  modules = {
    ["context"] = "src/context.lua",
    ["message"] = "src/message.lua",
    ["rules.absent"] = "src/rules/absent.lua",
    ["rules.all"] = "src/rules/all.lua",
    ["rules.between"] = "src/rules/between.lua",
    ["rules.dummy"] = "src/rules/dummy.lua",
    ["rules.equals"] = "src/rules/equals.lua",
    ["rules.key"] = "src/rules/key.lua",
    ["rules.never"] = "src/rules/never.lua",
    ["rules.number"] = "src/rules/number.lua",
    ["rules.numeric"] = "src/rules/numeric.lua",
    ["rules.positive"] = "src/rules/positive.lua",
    ["rules.string"] = "src/rules/string.lua",
    ["validation"] = "src/validation.lua",
  }
}

dependencies = {
  "lua >= 5.2",
}

description = {
  license = "MIT",
  summary = "Validation library for Lua with fluent API and error message handling",
  detailed = "Validation library for Lua with fluent API and error message handling",
  homepage = "https://github.com/henriquemoody/LuaValidation",
}

source = {
  url = "git://github.com/henriquemoody/LuaValidation",
  tag = "0.1.1"
}
