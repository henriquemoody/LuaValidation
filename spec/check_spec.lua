local actual_message
local v = require("validation")
v.set_messager(
  function (message)
    actual_message = message
  end
)

describe("Validation of check() calls", function()

  it("must not display  messages when got not errors", function()
    v.equals("something"):check("something")

    assert.True(nil == actual_message)
  end)

  it("must use display affirmative rule", function()
    v.dummy(false):check("whatever")

    assert.are.equal(actual_message, '"whatever" with result "false" in affirmative mode')
  end)

  it("must use display negative rule", function()
    v.never(v.dummy(true)):check("whatever")

    assert.are.equal(actual_message, '"whatever" with result "true" in negative mode')
  end)

  it("must use display custom message", function()
    v.dummy(false):check("whatever", {message = "This is not right"})

    assert.are.equal(actual_message, "This is not right")
  end)

  it("must use translate message", function()
    v.dummy(false):check(
      "whatever",
      {
        translator = function (message)
          return '{{placeholder}} deve ser {{result}}'
        end
      }
    )

    assert.are.equal(actual_message, '"whatever" deve ser "false"')
  end)
end)
