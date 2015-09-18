describe("Validation with string rule", function()
  local string = require("validation.rules.string")

  local valid_inputs = {
    "A",
    "1",
  }

  local invalid_inputs = {
    42,
    true,
    false,
    {},
    function () end,
  }

  it("must set result as True when matches expected value", function()
    for _, value in ipairs(valid_inputs) do
      local context = {input = value}

      string().apply(context)

      assert.True(context.result, "Failed with " .. tostring(value))
    end
  end)

  it("must set result as False when does not match the expected value", function()
    for _, value in ipairs(invalid_inputs) do
      local context = {input = value}

      string().apply(context)

      assert.False(context.result, "Failed with " .. tostring(value))
    end
  end)

end)
