# Haskell Types

- [Types](#types)
- [Type Variables](#type-variables)
- [Typeclasses](#typeclasses)
- [Type Annotations](#type-annotations)

### Types
Haskell has a **static type system**. The type of every expression is known at compile time, which leads to safer code.\
Haskell has **type inference**, if we write a number, we don't have to tell Haskell it's a number.
It can infer that on its own, so we don't have to explicitly write out the types of our functions and expressions to get things done.

*Examples of types are*: Bool, Char, Int, Float, [Char], etc.\
Doing `:t` on an expression prints out the expression followed by `::` and its type.`::` reads as *"Has type of"* (e.g. `5 :: Int`)


Functions has types as well, defined in function type declarations:
```
removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]
```
`removeNonUppercase` has a type of `[Char] -> [Char]`, meaning that it maps from a string to a string.

### Type variables
Type variables are used to generalize types in function declarations.
Functions that have type variables are called **polymorphic functions**.

For example `head` returns the first element of a list, this means that its
return value is not of a specific type, but at the same time we want to express the idea that it will have the same type of list elements.\
`head :: [a] -> [a]`: takes a list of elements of a generic type a and return an element of type a.\
`fst :: (a, b) -> a`: Takes a tuple and return the first element. This does not mean that a and b are necessarily different types
but they can be and the returned value will have the same type of the first element in the tuple.

### Typeclasses
A typeclass is a sort of interface that defines some behaviour. If a type is a part of a typeclass, that means that
it supports and implements the behaviour the typeclass describes. You can think of them kind of as Java interfaces, only better. 
Some examples are Eq (types that support equality testing), Ord, Show, Num, Integral, Floating, etc.
Function type declaration can have the `=>` symbol inside. Everything before the => symbol is called a class constraint, for example
Eq a => a -> a -> Bool is a function that takes two parameters of the same type, that must be part of the Eq typeclass, and returns Bool

**Typeclasses members are Types**. For example `Int` is a member of typeclass `Eq` and it implements both `==` and `/=` to check equality. It is also part of `Ord` because it implements `>` `<` `>=` and `<=` to define ordering. It is part of `Show` and implements `show` in order to be represented as a string, and so on.

### Type annotations
Page 28 (starting from Read Typeclass)

# Higher Order Functions
Haskell functions can take functions as parameters and return functions
as return values. A function that does either of those is called a higher
order function. Higher order functions aren't just a part of the Haskell
experience, they pretty much are the Haskell experience. It turns out that
if you want to define computations by defining what stuff is instead of
defining steps that change some state and maybe looping them, higher
order functions are indispensable.

# Making Our Own Types and Typeclasses

- [Algebraic data types](#algebraic-data-types)
- [Type parameters](#type-parameters)

[StackOverflow: Haskell Type vs Data Constructor](https://stackoverflow.com/questions/18204308/haskell-type-vs-data-constructor)

### Algebraic data types
The `data` keyword can be used to make your own types. Let's take Bool as an example:
```
data Bool = False | True
```

`data` means that we're defining a new data type. The part before the `=` denotes the type, which is `Bool`. The parts after the `=` are **value constructors**.
They specify the different values that this type can have. The `|` is read as or. So we can read this as: the `Bool` type can have a value of `True` or `False`.
Both the type name and the value constructors have to be capital cased.

```
data Shape = Circle Float Float Float | Rectangle Float Float Float Float
```

`Shape` is the new type, `Circle` and `Rectangle` are the value constructors and they have three and four parameters.
This looks like OOP Shape abstract class with Circle and Rectangle extending it and their constructors take three and four parameters.
An important difference though is that Shape and Rectangle are not types, only shape is a type. You can't use Circle or Rectangle in
function types declarations. Shape -> Float is ok, Circle -> Float is not.
Remember, value constructors are just functions that take the fields as parameters and return a value of some type (like Shape) as a result

### Type parameters
#### Recap
```
data Shape = Circle Point Float | Rectangle Point Point
```
- `Shape` => Type definition (creates a new `Shape` type)
- `Circle` and `Rectangle` => Value constructors
- `Point` and `Float` => value parameters

Also, Shape is an algebraic type because is the sum of two values

#### Now let's talk about type parameters

```
data Maybe a = Nothing | Just a
```
`Maybe a` => Type Constructor because there is `a` involved
which is a **type parameter**

Depending on what we want this data type to hold when it's not Nothing,
this type constructor can end up producing a type of
Maybe Int, Maybe Car, Maybe String, etc.
No value can have a type of just Maybe, because that's not
a type per se, it's a type constructor
`a` will not be replaced by a value but by a type (Int, Float, String, etc.)
So if we pass Char as the type parameter to Maybe, we get a type of Maybe Char.
The value Just 'a' has a type of Maybe Char

## Typeclasses
Typeclasses are often confused with classes in languages like
Java, Python, C++ and the like, which then baffles a lot of people.
In those languages, classes are a blueprint from which we then
create objects that contain state and can do some actions.
Typeclasses are more like interfaces. We don't make data from typeclasses.
Instead, we first make our data type and then we think about what it can act like.
If it can act like something that can be equated, we make it
an instance of the Eq typeclass.
If it can act like something that can be ordered, we make it
an instance of the Ord typeclass.

## Type Synonyms
Type synonyms don't really do anything per se, they're just about giving some types different names so that they make more sense to someone reading our code and documentation. Here's how the standard library defines String as a synonym for [Char].
```
type String = [Char]
```
We've introduced the type keyword. The keyword might be misleading to some,
because we're not actually making anything new (we did that with the data keyword),
but we're just making a synonym for an already existing type.
