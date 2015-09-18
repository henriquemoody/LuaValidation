package = "validation"
version = "0.1-1"

build = {
  type = "builtin",
  modules = {
    ["validation"] = "src/validation.lua",
    ["validation.context"] = "src/context.validation/lua",
    ["validation.message"] = "src/message.validation/lua",
    ["validation.rules.absent"] = "src/validation/rules/absent.lua",
    ["validation.rules.all"] = "src/validation/rules/all.lua",
    ["validation.rules.between"] = "src/validation/rules/between.lua",
    ["validation.rules.dummy"] = "src/validation/rules/dummy.lua",
    ["validation.rules.equals"] = "src/validation/rules/equals.lua",
    ["validation.rules.key"] = "src/validation/rules/key.lua",
    ["validation.rules.never"] = "src/validation/rules/never.lua",
    ["validation.rules.number"] = "src/validation/rules/number.lua",
    ["validation.rules.numeric"] = "src/validation/rules/numeric.lua",
    ["validation.rules.positive"] = "src/validation/rules/positive.lua",
    ["validation.rules.string"] = "src/validation/rules/string.lua",
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
