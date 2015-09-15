local key = require("rules.key")
local context = require("context")
local dummy = require("rules.dummy")

describe("Validation using key rule", function()

  it("must validate when key exists", function()
    local input = {some = true}
    local context = {input = input}

    key("some").apply(context)

    assert.True(context.result)
  end)

  it("must validate when key exists and it is false", function()
    local input = {some = false}
    local context = {input = input}

    key("some").apply(context)

    assert.True(context.result)
  end)

  it("must validate against defined rule when it pass", function()
    local input = {some = "whatever"}
    local tested_key = key("some", dummy(true))
    local tested_context = context.new(tested_key, {input = input})

    tested_key.apply(tested_context)

    assert.True(tested_context.result)
  end)

  it("must validate against defined rule when it does not pass", function()
    local input = {some = "whatever"}
    local tested_key = key("some", dummy(false))
    local tested_context = context.new(tested_key, {input = input})

    tested_key.apply(tested_context)

    assert.False(tested_context.result)
  end)

  it("must validate when it is not mandatory and there is no key", function()
    local input = {}
    local mandatory = false
    local tested_key = key("some", dummy(false), mandatory)
    local tested_context = context.new(tested_key, {input = input})

    tested_key.apply(tested_context)

    assert.True(tested_context.result)
  end)

  it("must only validate is key exists when no rule is defined", function()
    local input = {some = "whatever"}
    local tested_key = key("some")
    local tested_context = context.new(tested_key, {input = input})

    tested_key.apply(tested_context)

    assert.True(tested_context.result)
  end)
end)
