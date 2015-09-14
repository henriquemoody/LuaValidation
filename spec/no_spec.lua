describe("Validation of no constraint", function()
  local v = require("main")
  local equals = require("constraints.equals")

  it("Must assert true", function()
    assert.True(v.no(equals("foo")):validate("bar"))
  end)

  it("Must assert false", function()
    assert.False(v.no(equals("foo")):validate("foo"))
  end)

  it("Must assert true and false", function()
    assert.True(v.no(equals("foo")):validate("bar"))
    assert.False(v.no(equals("foo")):validate("foo"))
  end)
end)
