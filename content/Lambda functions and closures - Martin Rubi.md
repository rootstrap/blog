# Lambda functions and closures

Most programming languages have the concept of lambda functions, closures or both.

However each implementation is quite different.

The difference between implementations can be subtle yet it changes
quite a lot the patterns used in a program.

In this article I will talk about some implementations of closures
in different languages.

## What is a closure?

That's a question more difficult to answer than it should be because each language
gives a slightly different meaning to the word closure.

Instead of trying to define what a closure is I will go through different implementations
of lambda functions and closures.

## Functions

Most programming languages provide a means to reuse code.

A function is a piece of reusable code a programmer can define only once and call
many times.

Let's take an example of a function that adds to numbers:

```javascript
function sum(a, b) {
  return a + b
}
```

That's a function definition and the function it defines can be called with the code

```javascript
const total = sum(1,2)
```

It can also be called with


```javascript
const total = sum(3,4)
```

The definition of the function is stated once and the function can be called many
times, each time with its own set of arguments.

## Functions as arguments

In most programming languages a function can also be used as an argument to be
given to another function.

Not all languages support functions as first class objects though.

In the languages where functions are objects the previous `sum` example could be
written as

```javascript
const f = sum

const total = f(3,4)
```

In this code it doesn't make much sense to assign the function `sum` to a
variable instead of calling it directly but there are many case where it does.

One pattern that can benefit from using functions as parameters is using a function
parameter as an error handler instead of a `try/catch` or a conditional statement
to check the result

```javascript
const value = findItem({ id: 123,
  ifAbsent: (id)=>new Item({id})
})
```

The same example with `try/catch` would be

```javascript
const value = try {
  findItem({id: 123})
} catch(error) {
  new Item({id})
}
```

and with a conditional would be

```javascript
const result = findItem({id: 123})
const value = result !== 'absent' ? result : new Item({id})
```


Instead of returning an absent value or throwing an error the first function
accepts an argument to evaluate in the case that the searched id is not present.

# Lambda functions and closures

The previous example used a function without a name.

That's called a `lambda function`. In some contexts it's also called an anonymous function.

Lambda functions are functions that can be declared and defined on the fly without
a name within the body of another function. Just like any other literal value

The function

```javascript
(id)=>new Item({id})
```

does not have a name yet it's given as an argument to the function `findItem`.

A lamdba function can access any argument it receives.

For example the lambda function

```javascript
(id)=>new Item({id})
```

can read the value of its parameter named `id`.


Some languages also have the concept of `closure`.

Closures are very much like lambda functions with a subtle yet important difference.

Lambda functions can access only the parameters their receive and the variables
defined in their own body.

Closures can also read and write the values from the variables in the scope where
the closure was defined.

Lambda functions are implemented the same in all programming languages yet closures
can vary from one language to another.

I'll go through concrete examples in some programming languages

## PHP

PHP implements lambda functions through its relatively new sintax for
[Arrow functions](https://www.php.net/manual/en/functions.arrow.php)

```php
$value = findItem(
  123,
  ($id)=>new Item($id)
)
```

PHP does not implement full closures. Arrow functions can read variables defined
in its outer scope but not assign values to them.

The following code would **not** assign the value to the variable `$error` in its
scope

```php
$error = null
$value = findItem(
  123,
  ($id)=>$error = "Item not found"
)
```

## Python

Python implements lambda functions and closures with its own characteristics.

Unlike a regular function, Python lambda functions can have only a single statement.
Usually that's not an issue since the statement can be a call to a regular Python
function.

A lambda function in Python can read the value of a variable in its outer scope
but it can't assign a value to it.

To be able to assing the variable value a special declaration must be used,
[nonlocal](https://docs.python.org/3/reference/simple_stmts.html#grammar-token-nonlocal-stmt)

## Javascript

Javascript is a special case because almost everything in Javascript is a lambda
function. Even regular functions and classes.

In javascript lambda functions are also closures and can read and write variables
in their outer scope.

## Ruby

Ruby implements both lambda functions and closures.

A lambda function in Ruby is declared as

```ruby
sum = lambda {|a, b| return a + b}
value = sum.call(1, 2)
```

The same code as a closure is declared as

```ruby
sum = proc {|a, b| a + b}
value = sum.call(3, 4)
```

There's a interesting point in the Ruby implementation of closures.

In Ruby both lambda functions and closures can read and write variables declared
in its outer scope.

What's the difference between them?

The `return` statement.

Using a `return` statement in a lambda function returns the value to the scope
of the calling statement

```ruby
def calculate
  sum = lambda {|a, b| return a + b}
  value = sum.call(1,2)
  print value
end
```

Using a `return` statement in a closure returns the value from the scope of method

```ruby
def calculate
  sum = proc {|a, b| return a + b}
  value = sum.call(1,2)
  # this statement doesn't get called because the return within the closure
  # returns from the method scope
  print value
end
```

That seems odd. Why would a `return` statement return from the method context
instead of returning from the closure?

Hold that thought.


## Top-down vs bottom-up design

When it comes to design a solution to a problem there are at least two approaches
to take, top-down design and bottom-up design.

bottom-up design starts by designing the building blocks used in the upper
layer to solve the problem.

bottom-up is the most common design approach since it seems very reasonable.
After all to build the upper layer a lower layer is needed. bottom-up designs how
the solution must be used before defining it first case of use.

top-down design starts by designing the upper layer without having the lower layer
building blocks. That is, it starts by designing how it wants to use the solution
leaving its implementation to the future. top-down designs how a concrete use case
would use the solution before implementing it.

bottom-up designs usually produce solutions more simple to implement.

top-down designs usually produce solutions more simple to use.

It's not possible to think a `return` statement doing anything else than returning
from the lambda function scope with a bottom-up design because of the lack of
the context of use.

To think a lambda function in isolation is a decision to not to think the lamdba
function in the context of the caller.

## Ruby closures

The behaviour of the `return` statement in Ruby was taken from the implementation
of closures in the Smalltalk language.

Odd as it seems it allows the following pattern

```ruby
def name_of_item(id:)
  item = find_item(id: id, if_absent: proc{ return 'not found' })
  item.name
end
```

or if you prefer a one-liner

```ruby
def name_of_item(id:)
  find_item(id: id, if_absent: proc{ return 'not found' }).name
end
```

Smalltalk sintax for inlined closures makes the expression a bit more clear to read

```smalltalk
nameOfItemWith: id
  |item|
  item := self findItemWith: id ifAbsent: [ ^'not found' ]
  ^item name
```

Here's another example in Ruby of the same pattern used to implement a `find(&block)`
method based on an existing `each(&block)` method

```ruby
def find(&block)
  self.each do |item|
    return item if block.call(item)
  end
  raise NotFoundError.new
end
```

The return statement within the loop returns from the `find` method, not just
from the `each` closure. That is something that can't be accomplished using
Javascript `forEach()`
