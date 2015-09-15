local v = require("validation")

describe("The assert() calls", function()

  stub(v, "display")

  it("must display all messages when all got errors", function()
    local message = [[
All constraints must pass for "whatever"
 - "whatever" must be equals to "something"
 - "whatever" must be equals to "something else"]]
    v.equals("something").equals("something else"):assert("whatever")

    assert.stub(v.display).was.called_with(message)
  end)

  it("must display only error messages which did not pass", function()
    local message = [[
These constraints must pass for "nil"
 - "nil" must be equals to "whatever"]]
    v.dummy(true).equals("whatever"):assert(nil)

    assert.stub(v.display).was.called_with(message)
  end)

  it("must display negative messages", function()
    local message = [[
These constraints must pass for "foo"
 - "foo" must not be equals to "foo"
 - "foo" have not to be "true"
 - "foo" have to be "false"]]
    v
      .never(v.equals("foo"))
      .equals("foo")
      .never(v.dummy(true))
      .never(v.never(v.dummy(false)))
      :assert("foo")

    assert.stub(v.display).was.called_with(message)
  end)

  it("must display key messages", function()
    local message = [[
All constraints must pass for "your data"
 - "foo" have to be "false"
 - "bar" must be present
 - "baz" have to be "false"]]
    v
      .key("foo", v.dummy(false))
      .key("bar", v.dummy(true))
      .key("baz", v.dummy(false))
      :assert({foo = true, baz = true}, {name = "your data"})

    assert.stub(v.display).was.called_with(message)
  end)

  it("must display key recursive messages", function()
    local message = [[
All constraints must pass for "your data"
 - All constraints must pass for "mysql"
  - "host" must be a valid string
  - "port" cannot be a string
  - "user" must be present
  - "password" must be present
  - "schema" must be a valid string
 - All constraints must pass for "postgresql"
  - "host" must be present
  - "user" must be a valid string
  - "password" must be a valid string
  - "schema" must be present]]

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

    assert.stub(v.display).was.called_with(message)
  end)
end)
