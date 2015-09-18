describe("Validation of no rule", function()
  local context = {}
  local dummy = require("validation.rules.dummy")

  it("Must use the defined value", function()
    dummy(true).apply(context)

    assert.True(context.result)
  end)
end)
