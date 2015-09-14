describe("Validation of notNil constraint", function()
  local v = require("main")

  it("Must assert true", function()
    assert.True(v.notNil():validate("Not nil"))
  end)

  it("Must assert false", function()
    assert.False(v.notNil():validate(nil))
  end)

  it("Must assert true and false", function()
    assert.True(v.notNil():validate("Not nil"))
    assert.False(v.notNil():validate(nil))
  end)
end)
