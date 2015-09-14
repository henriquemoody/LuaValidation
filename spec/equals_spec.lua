describe("Validation of equals constraint", function()
  local v = require("main")

  it("Must assert true", function()
    assert.True(v.equals("foo"):validate("foo"))
  end)

  it("Must assert false", function()
    assert.False(v.equals("foo"):validate("bar"))
  end)

  it("Must assert true and false", function()
    assert.True(v.equals("foo"):validate("foo"))
    assert.False(v.equals("foo"):validate("bar"))
  end)
end)
