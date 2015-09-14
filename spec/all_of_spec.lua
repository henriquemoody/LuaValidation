describe("Validation of all_of constraint", function()
  local v = require("main")
  local not_nil = require("constraints.not_nil")
  local equals = require("constraints.equals")

  it("Must assert true", function()
    assert.True(v.all_of(not_nil(), equals("foo")):validate("foo"))
  end)

  it("Must assert false", function()
    assert.False(v.all_of(not_nil(), equals("foo")):validate(nil))
  end)

  it("Must assert true and false", function()
    assert.True(v.all_of(not_nil(), equals("foo")):validate("foo"))
    assert.False(v.all_of(not_nil(), equals("foo")):validate(nil))
  end)
end)
