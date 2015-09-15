# validation

Validation library for Lua with fluent API and error message handling inspired
by [Respect\Validation](https://github.com/Respect/Validation).

## Usage

This library follows the same principals of fluent API of [Respect\Validation][],
so you're able to create chains like it:

```lua
local v = require("validation")

v.numeric().positive().between(1, 256)
```

There are more than only one way to performa validation against you data with
_validation_, we have 3 methods:

- `is_valid()`
- `assert()`
- `check()`

## `assert()`

This method returns a boolean value which says if you'r data is

```lua
v.equals("foo"):assert(input)
```

By default you it prints the results but you can create

## `is_valid()`

This method returns a boolean value which says if you'r data is

```lua
if v.equals("foo"):is_valid(input) then
  // Do something
end
```


[Respect\Validation]: https://github.com/Respect/Validation "Respect\Validation"
