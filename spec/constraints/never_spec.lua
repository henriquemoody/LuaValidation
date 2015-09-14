local context = require("context")
local dummy = require("constraints.dummy")
local never = require("constraints.never")

describe("Validation of no constraint", function()
  it("Must deny the result of defined constraint", function()
    local tested_constraint = never(dummy(false))
    local tested_context = context.new(tested_constraint, {input = "whatever"})

    tested_constraint.apply(tested_context)

    assert.True(tested_context.result)
  end)
end)
