# LuaValidation

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

- `assert()`
- `check()`
- `validate()`

### assert()

This method validates the entire chain and produces its message.

```lua
v.numeric().positive().between(1, 256):assert(0)
```

The code above should produce this message:

```text
Some rules must pass for "0"
 - "0" must be positive
 - "0" must be between "1" and "256"
```

By default you it uses `error()` as default message handler, but you change this
behaviour by defining a new _message_ with `v.set_message()` which accepts a
callback as an argument.

### check()

Works like `assert()` but is produces only the message of the first rule of the
rule which did not pass the validation.

```lua
v.numeric().positive():check(nil)
```

The code above should produce this message:
```text
"nil" must be numeric
```

### validate()

This method returns a boolean value which says if the input is valid or not.

```lua
if v.equals("foo"):validate(input) then
  -- Do something
end
```

## Available rules

- `absent()`: Checks if the input is `nil`
- `all(...)`: Performs validation of all rules defined on its constructor against the input
- `between(minimum, maximum)`: Checks if the input is between `minimum` and `maximum`
- `dummy(result)`: Performs validation exactly according to what was defined as `result` on its constructor
- `equals(expected)`: Checks if the input is equal to the `expected` value
- `key(key, rule, mandatory)`: Performs validation of `rule` againts the value of `key` of the input.
   If `mandatory` is `true` (which is the default value), also checks if the `key` exists in the input.
- `never(rule)`: Performs the reverse validation of the `rule` in the given input
- `number()`: Checks if the input is a number
- `numeric()`: Checks if the input is a numeric value
- `positive()`: Checks if the input is a positive value
- `string()`: Checks if the input is a string

There's just a few rules, but soon there will be as much as on [Respect\Validation][],
if you want to contribute it will be a preasure for me.

[Respect\Validation]: https://github.com/Respect/Validation "Respect\Validation"
