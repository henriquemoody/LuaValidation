describe("Validation of equals constraint", function()
  local v = require("main")

  it("Must use display normal constraint", function()
    stub(v, "display")

    v.nil_value():check("Not nil")

    assert.stub(v.display).was.called_with('"Not nil" must be `nil`')
  end)

  it("Must use display custom message", function()
    stub(v, "display")

    v.nil_value():check("Not nil", {message = "This is not right"})

    assert.stub(v.display).was.called_with("This is not right")
  end)
end)
