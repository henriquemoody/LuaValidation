local context = require("context")
local dummy = require("rules.dummy")
local never = require("rules.never")

describe("Validation of no rule", function()
  it("Must deny the result of defined rule", function()
    local tested_rule = never(dummy(false))
    local tested_context = context.new(tested_rule, {input = "whatever"})

    tested_rule.apply(tested_context)

    assert.True(tested_context.result)
  end)
end)
