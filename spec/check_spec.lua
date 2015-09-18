describe("Validation of check() calls", function()
  local v = require("validation")

  stub(v, "messager")

  it("must not display  messages when got not errors", function()
    v.equals("something"):check("something")

    assert.stub(v.messager).was_not.called()
  end)

  it("Must use display affirmative rule", function()
    v.dummy(false):check("whatever")

    assert.stub(v.messager).was.called_with('"whatever" with result "false" in affirmative mode')
  end)

  it("Must use display negative rule", function()
    v.never(v.dummy(true)):check("whatever")

    assert.stub(v.messager).was.called_with('"whatever" with result "true" in negative mode')
  end)

  it("Must use display custom message", function()
    v.dummy(false):check("whatever", {message = "This is not right"})

    assert.stub(v.messager).was.called_with("This is not right")
  end)

  it("Must use translate message", function()
    v.dummy(false):check(
      "whatever",
      {
        translator = function (message)
          return '{{placeholder}} deve ser {{result}}'
        end
      }
    )

    assert.stub(v.messager).was.called_with('"whatever" deve ser "false"')
  end)
end)
