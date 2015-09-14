local v = require("main")

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
end)
