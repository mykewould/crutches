defmodule Crutches.Option do
  @moduledoc ~S"""
  Convenience functions for dealing with funciton option handling.

  It provides a mechanism for declaring default options and merging these with
  those given by any caller.

  ## Usage

  When you have a function with the following head, the use of this module may
  be beneficial. Of course you can have as much required `args` as you want.
  `options` is a keyword list.

  ```
    def foo(args, options)
  ```

  Usage is pretty simple. Declare a module attribute with the name of your
  function. It should be a keyword list with the keys `:valid` and `:defaults`.
  `:valid` should contain a list of atoms. `:defaults` should contain another
  keyword list with the default options of your function.

  Example:

  ```
  @function_name [
    valid: ~w(foo bar)a
    defaults: [
      foo: "some",
      bar: "value"
    ]
  ]
  ```

  When this is done, you can declare your function head like this:

  ```
  def function_name(args, opts \\ @function_name[:defaults])
  ```

  And then you're all set to actually write the meat of your function. (You of
  course don't need a function head if your function only consists of one clause.)

  ```
  def function_name(args, opts) do
    # This validates and merges the options, throwing on error.
    opts = Crutches.Options.combine!(opts, @function_name)

    # You can now use the options.
    do_something_with(opts[:foo])
  end
  ```
  """

  @doc ~S"""
  Validates the `opts` keyword list according to `config`, combines defaults.

  For intended use see the module documentation.

  The `config` parameter should be a keyword list with the following keys:

    - `:valid`    -- list of atoms of options that your function accepts.
    - `:defaults` -- keyword list of default values for the options in `:valid`

  Returns `{:ok, opts}` on succes, `{:error, invalid_keys}` on failure.

  ### Examples

      iex> config = [valid: ~w(foo bar)a, defaults: [foo: "some", bar: "value"]]
      iex> Option.combine([foo: "another"], config)
      {:ok, [foo: "another", bar: "value"]}

      iex> config = [valid: ~w(bar baz)a, defaults: [bar: "good", baz: "values"]]
      iex> Option.combine([boom: "this blows up"], config)
      {:error, [:boom]}

  """
  def combine(opts, config) do
    case Crutches.Keyword.validate_keys(opts, config[:valid]) do
      {:ok, _} -> {:ok, Elixir.Keyword.merge(config[:defaults], opts)}
      {:error, invalid} -> {:error, invalid}
    end
  end

  @doc ~S"""
  Validates the `opts` keyword list according to `config`, combines defaults.

  For intended use see the module documentation.

  The `config` parameter should be a keyword list with the following keys:

    - `:valid`    -- list of atoms of options that your function accepts.
    - `:defaults` -- keyword list of default values for the options in `:valid`

  Returns `options` on succes, throws `ArgumentError` on failure.

  ### Examples

      iex> config = [valid: ~w(foo bar)a, defaults: [foo: "some", bar: "value"]]
      iex> Option.combine!([foo: "another"], config)
      [foo: "another", bar: "value"]

      iex> config = [valid: ~w(bar baz)a, defaults: [bar: "good", baz: "values"]]
      iex> Option.combine!([boom: "this blows up"], config)
      ** (ArgumentError) invalid key boom

  """
  def combine!(opts, config) do
    case Crutches.Option.combine(opts, config) do
      {:ok, opts} -> opts
      {:error, invalid} ->
        invalid = invalid |> Enum.map_join(" ", &(to_string(&1)))
        raise ArgumentError, message: "invalid key #{invalid}"
    end
  end
end
