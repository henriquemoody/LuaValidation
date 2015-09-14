describe("Validation of not_nil constraint", function()
  local v = require("main")

  it("Must assert true", function()
    assert.True(v.not_nil():validate("Not nil"))
  end)

  it("Must assert false", function()
    assert.False(v.not_nil():validate(nil))
  end)

  it("Must assert true and false", function()
    assert.True(v.not_nil():validate("Not nil"))
    assert.False(v.not_nil():validate(nil))
  end)
end)
