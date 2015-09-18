local all = require("validation.rules.all")
local context = require("validation.context")
local dummy = require("validation.rules.dummy")

describe("Validation of all rule", function()

  it("Must define context result as true", function()
    local tested_rule = all(dummy(true), dummy(true))
    local tested_context = context.new()

    tested_rule.apply(tested_context)

    assert.True(tested_context.result)
  end)

  it("Must define context result as false", function()
    local tested_rule = all(dummy(false), dummy(true))
    local tested_context = context.new()

    tested_rule.apply(tested_context)

    assert.False(tested_context.result)
  end)
end)
