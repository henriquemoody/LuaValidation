describe("Validation with number rule", function()
  local number = require("rules.number")

  local valid_inputs = {
    42,
    12,
    0,
  }

  local invalid_inputs = {
    true,
    false,
    nil,
    "1",
    {},
    function () end,
  }

  it("must set result as True when matches expected value", function()
    for _, value in ipairs(valid_inputs) do
      local context = {input = value}

      number().apply(context)

      assert.True(context.result, "Failed with " .. tostring(value))
    end
  end)

  it("must set result as False when does not match the expected value", function()
    for _, value in ipairs(invalid_inputs) do
      local context = {input = value}

      number().apply(context)

      assert.False(context.result, "Failed with " .. tostring(value))
    end
  end)

end)
