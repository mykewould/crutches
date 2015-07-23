Crutches
=======

The start of an Elixir ~~ripoff~~ port to the [ActiveSupport Ruby gem](https://github.com/rails/rails/tree/master/activesupport).

### New to Elixir, and coming from Ruby?
This library is a great for Elixir beginners to contribute to. By porting over ActiveSupport most of the documentation and specs have been written for the methods. This allows the contributor to focus on the syntax and nuances of Elixir. The bonus here is that the contributor will be helping an open source project while learning the basics.

### How to contribute
* Fork crutches.
* Pick an issue to implement.
* If you pick an issue from the list, please comment on the issue to let others know you've started on it.
* If you don't see a function you'd like to implement in the issues section, feel free to go grab one from ActiveSupport, or implement a unique function.
* The documentation is written for Ruby, start by converting that into a doctest in Elixir.
* Use TDD to solve the doctest.
* Open a PR

### Why ActiveSupport?
ActiveSupport has some great goodies that are useful in web application development. Furthermore the design pattern for ActiveSupport, and it's use cases, are not hard to understand. If you are coming from the Rails community, being a contributor on this project shouldn't be overly difficult.

### Current Functions Available

#### String
* camelize
* from
* remove
* squish
* to
* underscore

#### List
* from
* shorten
* split
* to
* to_sentence

#### Enum
* without
* many?

#### Integer
* multiple_of
* ordinal
* ordinalize

### License
MIT
