describe("Validation of equals constraint", function()
  local constraint = require("constraints.equals")

  local valid_inputs = {
    {"foo", "foo"},
    {"1", "1"},
    {true, true},
  }

  local invalid_inputs = {
    {"foo", "fo"},
    {true, false},
    {nil, false},
  }

  it("Must set result as True when matches expected value", function()
    for _, values in ipairs(valid_inputs) do
      local context = {input = values[2]}

      constraint(values[1]).apply(context)

      assert.True(context.result)
    end
  end)

  it("Must set result as False when does not match the expected value", function()
    for _, values in ipairs(invalid_inputs) do
      local context = {input = values[2]}

      constraint(values[1]).apply(context)

      assert.False(context.result)
    end
  end)

  it("Must set expected value when applying context", function()
    for _, values in ipairs(invalid_inputs) do
      local context = {input = values[2]}

      constraint(values[1]).apply(context)

      assert.Same(values[1], context.expected)
    end
  end)
end)
