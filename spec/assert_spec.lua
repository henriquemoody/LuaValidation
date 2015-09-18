local actual_message
local v = require("validation")
v.set_messager(
  function (message)
    actual_message = message
  end
)

describe("The assert() calls", function()

  it("must not display  messages when got not errors", function()
    v.equals("something"):assert("something")

    assert.True(nil == actual_message)
  end)

  it("must display all messages when all got errors", function()
    local expected_message = [[
All rules must pass for "whatever"
 - "whatever" must be equal to "something"
 - "whatever" must be equal to "something else"]]
    v.equals("something").equals("something else"):assert("whatever")

    assert.are.equal(actual_message, expected_message)
  end)

  it("must use custom message only for the first rule", function()
    local expected_message = [[
Please, provide some valid data
 - "whatever" must be equal to "something"
 - "whatever" must be equal to "something else"]]
    v.equals("something").equals("something else"):assert("whatever", {message = "Please, provide some valid data"})

    assert.are.equal(actual_message, expected_message)
  end)

  it("must display only error messages which did not pass", function()
    local expected_message = [[
Some rules must pass for "nil"
 - "nil" must be equal to "whatever"]]
    v.dummy(true).equals("whatever"):assert(nil)

    assert.are.equal(actual_message, expected_message)
  end)

  it("must display negative messages", function()
    local expected_message = [[
Some rules must pass for "foo"
 - "foo" cannot be equal to "foo"
 - "foo" with result "true" in negative mode
 - "foo" with result "false" in affirmative mode]]
    v
      .never(v.equals("foo"))
      .equals("foo")
      .never(v.dummy(true))
      .never(v.never(v.dummy(false)))
      :assert("foo")

    assert.are.equal(actual_message, expected_message)
  end)

  it("must display key messages", function()
    local expected_message = [[
All rules must pass for "your data"
 - "foo" with result "false" in affirmative mode
 - "bar" must be defined
 - "baz" with result "false" in affirmative mode]]
    v
      .key("foo", v.dummy(false))
      .key("bar", v.dummy(true))
      .key("baz", v.dummy(false))
      :assert({foo = true, baz = true}, {name = "your data"})

    assert.are.equal(actual_message, expected_message)
  end)

  it("must display key recursive messages", function()
    local expected_message = [[
All rules must pass for "your data"
 - All rules must pass for "mysql"
  - "host" must be a string
  - "port" cannot be a string
  - "user" must be defined
  - "password" must be defined
  - "schema" must be a string
 - All rules must pass for "postgresql"
  - "host" must be defined
  - "user" must be a string
  - "password" must be a string
  - "schema" must be defined]]

    v
      .key(
        "mysql",
        v
          .key("host", v.string(), true)
          .key("port", v.never(v.string()), true)
          .key("user", v.string(), true)
          .key("password", v.string(), true)
          .key("schema", v.string(), true),
        true
      )
      .key(
        "postgresql",
        v
          .key("host", v.string(), true)
          .key("user", v.string(), true)
          .key("password", v.string(), true)
          .key("schema", v.string(), true),
        true
      )
      :assert(
        {
          mysql = {
            host = 42,
            port = "string",
            schema = 42,
          },
          postgresql = {
            user = 42,
            password = 42,
          },
        },
        {name = "your data"}
      )

    assert.are.equal(actual_message, expected_message)
  end)
end)
