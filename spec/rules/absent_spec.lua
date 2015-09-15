describe("Validation of absent rule", function()
  local rule = require("rules.absent")

  local valid_inputs = {
    nil
  }

  local invalid_inputs = {
    "foo",
    true,
    {},
  }

  it("Must set result as True when matches expected value", function()
    for _, value in ipairs(valid_inputs) do
      local context = {input = value}

      rule().apply(context)

      assert.True(context.result, "Failed with " .. tostring(value))
    end
  end)

  it("Must set result as False when does not match the expected value", function()
    for _, value in ipairs(invalid_inputs) do
      local context = {input = value}

      rule().apply(context)

      assert.False(context.result, "Failed with " .. tostring(value))
    end
  end)

end)
