describe("Validation with numeric rule", function()
  local numeric = require("rules.numeric")

  local valid_inputs = {
    12,
    -1,
    "0",
    "-5.5",
    "100000.5",
  }

  local invalid_inputs = {
    true,
    false,
    nil,
    "a",
    {},
    function () end,
  }

  it("must set result as True when matches expected value", function()
    for _, value in ipairs(valid_inputs) do
      local context = {input = value}

      numeric().apply(context)

      assert.True(context.result, "Failed with: " .. tostring(value))
    end
  end)

  it("must set result as False when does not match the expected value", function()
    for _, value in ipairs(invalid_inputs) do
      local context = {input = value}

      numeric().apply(context)

      assert.False(context.result, "Failed with: " .. tostring(value))
    end
  end)

end)
