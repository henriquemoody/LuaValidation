local all_of = require("constraints.all_of")
local context = require("context")
local dummy = require("constraints.dummy")

describe("Validation of all_of constraint", function()

  it("Must define context result as true", function()
    local tested_constraint = all_of(dummy(true), dummy(true))
    local tested_context = context.new()

    tested_constraint.apply(tested_context)

    assert.True(tested_context.result)
  end)

  it("Must define context result as false", function()
    local tested_constraint = all_of(dummy(false), dummy(true))
    local tested_context = context.new()

    tested_constraint.apply(tested_context)

    assert.False(tested_context.result)
  end)
end)
