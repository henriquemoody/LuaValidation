describe("Validation with between rule", function()
  local between = require("rules.between")

  local valid_inputs = {
    {2, 1, 3},
    {"3", 1, 3},
    {5, 1, 10},
    {-10, -20, 0},
  }

  local invalid_inputs = {
    {0, 1, 10},
    {-1, 1, 10},

    {true, 1, 10},
    {false, 1, 10},
    {nil, 1, 10},
    {{}, 1, 10},
    {function () end, 1, 10},
  }

  it("must set result as True when matches expected value", function()
    for _, values in ipairs(valid_inputs) do
      local context = {input = values[1]}

      between(values[2], values[3]).apply(context)

      assert.True(context.result, "Failed with: " .. tostring(values[1]) .. " when " .. tostring(values[2]) .. " and " .. values[3])
    end
  end)

  it("must set result as False when does not match the expected value", function()
    for _, values in ipairs(invalid_inputs) do
      local context = {input = values[1]}

      between(values[2], values[3]).apply(context)

      assert.False(context.result, "Failed with: " .. tostring(values[1]) .. " when " .. tostring(values[2]) .. " and " .. values[3])
    end
  end)

end)
