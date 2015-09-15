package = "validation"
version = "0.1-0"

build = {
  type = "builtin",
  modules = {
    validation = "src/validation.lua",
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
  tag = "0.1.0"
}
