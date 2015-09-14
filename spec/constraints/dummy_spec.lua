describe("Validation of no constraint", function()
  local context = {}
  local dummy = require("constraints.dummy")

  it("Must use the defined value", function()
    dummy(true).apply(context)

    assert.True(context.result)
  end)
end)
