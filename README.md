# LuaValidation

Validation library for Lua with fluent API and error message handling inspired
by [Respect\Validation](https://github.com/Respect/Validation).

## Instalation

You can install it by using [LuaRocks](https://luarocks.org).

```bash
luarocks install validation
```

## Usage

The fluent API of library follows the same principles of [Respect\Validation][].

### Module import

After installing LuaValidation you can simple import it:

```lua
local v = require("validation")
```

### Chained validation

It is possible to use validators in a chain.

```lua
v.numeric().positive().between(1, 256)
```

### Validation functions

There are more than only one way to perform validation against you data with
LuaValidation:

- `assert()`
- `check()`
- `validate()`

#### assert()

This function validates the entire chain and produces its message.

```lua
v.numeric().positive().between(1, 256):assert(0)
```

The code above should produce this message:

```text
Some rules must pass for "0"
 - "0" must be positive
 - "0" must be between "1" and "256"
```

#### check()

Works like `assert()` but is produces only the message of the first rule of the
rule which did not pass the validation.

```lua
v.numeric().positive():check(nil)
```

The code above should produce this message:
```text
"nil" must be numeric
```

#### validate()

This function returns a boolean value which says if the input is valid or not.

```lua
if v.equals("foo"):validate(input) then
  -- Do something
end
```

### Reusable chain

Once created, you can reuse your chain anywhere:

```lua
local my_chain = v.numeric().positive().between(1, 256)

my_chain:check(first)
my_chain:check(second)
my_chain:check(third)
```

### Custom message handler

By default you it uses `error()` as default message handler, but you change this
behavior by defining a new _messager_ with `v.set_messager()` which accepts a
callback as an argument.

```lua
v.set_messager(
    function (message)
        print(">>>", message)
    end
)
```

### Custom messages

When you use `assert()` and `check()`, you can define a custom message for you
message:

```lua
v.numeric():check(nil, {message = "Something is not right"})
```

The above code produces this message:

```text
Something is not right
```

### Custom names

When you use `assert()` and `check()`, sometimes you just want to name it:

```lua
v.numeric():check(nil, {name = "Name"})
```

The above code produces this message:

```text
"Name" must be numeric
```

## Available rules

- `absent()`: Checks if the input is `nil`
- `all(...)`: Performs validation of all rules defined on its constructor against the input
- `between(minimum, maximum)`: Checks if the input is between `minimum` and `maximum`
- `dummy(result)`: Performs validation exactly according to what was defined as `result` on its constructor
- `equals(expected)`: Checks if the input is equal to the `expected` value
- `key(key, rule, mandatory)`: Performs validation of `rule` against the value of `key` of the input.
   If `mandatory` is `true` (which is the default value), also checks if the `key` exists in the input.
- `never(rule)`: Performs the reverse validation of the `rule` in the given input
- `number()`: Checks if the input is a number
- `numeric()`: Checks if the input is a numeric value
- `positive()`: Checks if the input is a positive value
- `string()`: Checks if the input is a string

There's just a few rules, but soon there will be as much as on [Respect\Validation][],
if you want to contribute it will be a pleasure for me.

[Respect\Validation]: https://github.com/Respect/Validation "Respect\Validation"
