# Crutches [![Build Status]][build-link] [![Docs Status]][docs-ci-link] [![Hex Version]][version-link] ![License]

**Alpha software.** Utility library for Elixir, inspired by ActiveSupport.

 - [Documentation][docs]
 - [License][license] &mdash; MIT
 - [How to contribute][contributing-info] &mdash; We don't bite. Join in on
   the fun!

## Installation

You can get Crutches from Hex. Add the following to your `mix.exs` file and run
`mix deps.get` afterwards:

```elixir
defp deps do
  [{:crutches, "~> 0.0.5"}]
end
```

## Usage

If you want to import all functions provided by Crutches, `use` it in your module:

```elixir
defmodule Foo do
  use Crutches
end
```

If you only need a specific part of the library, you can `import` it:

```elixir
defmodule Bar do
  import Crutches.Option
end
```

## Project status, compatibility and versioning

**Alpha software.** APIs and supported Elixir or Erlang versions may change without
notice. Use with discretion.

We specifically test our code against the following combinations of Erlang/OTP and
Elixir:

| Erlang | Elixir 	 |
|------- |--------- |
| `18.0`	| `1.0.5` 	|

## Learn Elixir with us!

Crutches is a great for Elixir beginners to contribute to. We are writing
convenience functions as an addition to the Elixir standard library, a lot of which
are inspired by ActiveSupport (a similar project from the Ruby world).

The great thing about a utility library is that it is easy to contribute without
having to know a lot about the entire codebase. You can easily add a new function
in a vacuum, without having to know about the rest of the codebase. Furthermore,
we provide a list of features to be implemented, complete with tests, so you can get
started right away, even if you don't have any ideas.

We want to be a safe place for anyone to get started with Elixir or with contributing
to an open source project. If you see anything that isn't proper in your eyes, then be
sure to let one of the collaborators know!

Sounds good? Take a look at the [contributing information][contributing-info]
to get started. If anything is unclear, or if you are unsure about something, feel free
to contact one of the collaborators.

 [docs]:http://hexdocs.pm/crutches/
 [contributing-info]: https://github.com/mykewould/crutches/blob/master/CONTRIBUTING.md
 [license]:https://github.com/mykewould/crutches/blob/master/LICENSE
 
 [Build Status]:https://travis-ci.org/mykewould/crutches.svg?branch=master
 [Hex Version]:https://img.shields.io/hexpm/v/crutches.svg?label=hex%20version
 [Docs Status]:http://inch-ci.org/github/mykewould/crutches.svg?branch=master
 [License]:https://img.shields.io/hexpm/l/crutches.svg

 [build-link]:https://travis-ci.org/mykewould/crutches
 [version-link]:https://hex.pm/packages/crutches
 [docs-ci-link]:http://inch-ci.org/github/mykewould/crutches
