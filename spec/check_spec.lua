describe("Validation of equals constraint", function()
  local v = require("main")

  it("Must use display normal constraint", function()
    stub(v, "display")

    v.not_nil():check(nil)

    assert.stub(v.display).was.called_with('"nil" must not be `nil`')
  end)

  it("Must use display custom message", function()
    stub(v, "display")

    v.not_nil():check(nil, {message = "This is not right"})

    assert.stub(v.display).was.called_with("This is not right")
  end)
end)
