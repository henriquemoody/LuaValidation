local v = require("validation")

describe("Validation of is_valid() calls", function()
  it("Must validate valid chains", function()
    for index, chain in pairs({
        v.dummy(true),
        v.dummy(true).dummy,
        v.dummy(true).dummy(true).dummy(true),
      }) do
      assert.True(chain:is_valid("whatever"), "Failed at chain #" .. index)
    end
  end)

  it("Must invalidate invalid chains", function()
    for index, chain in pairs({
      v.dummy(false),
      v.dummy(false).dummy(false),
      v.dummy(false).dummy(true),
      v.dummy(true).dummy(false),
      v.dummy(false).dummy(false).dummy(false),
      v.dummy(false).dummy(false).dummy(true),
      v.dummy(false).dummy(true).dummy(true),
      v.dummy(true).dummy(true).dummy(false),
      v.dummy(true).dummy(false).dummy(false),
    }) do
      assert.False(chain:is_valid("whatever"), "Failed at chain #" .. index)
    end
  end)

  it("Should not keep rules in chains", function()
    assert.False(v.dummy(false):is_valid("whatever"))
    assert.True(v.dummy(true):is_valid("whatever"))
  end)

  it("Must validate chains with never rules", function()
    assert.False(v.never(v.dummy(true)):is_valid("whatever"))
    assert.True(v.never(v.dummy(false)):is_valid("whatever"))
  end)
end)
