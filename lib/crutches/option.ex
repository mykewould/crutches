defmodule Crutches.Option do
  @moduledoc """
  Convenience functions for dealing with funciton option handling.

  This provides a mechanism for declaring default options and merging these with
  those given by any caller.

  # Usage

  When you have a function with the following head, the use of this module may
  be beneficial. Of course you can have as much required `args` as you want.
  `options` is a keyword list.

      def foo(args, options)

  Usage is pretty simple. Declare a module attribute with the name of your
  function. It should be a keyword list with the keys `:valid` and `:defaults`.
  `:valid` should contain a list of atoms. `:defaults` should contain another
  keyword list with the default options of your function.

  ## Example

      @function_name [
        valid: ~w(foo bar)a
        defaults: [
          foo: "some",
          bar: "value"
        ]
      ]

  When this is done, you can declare your function head like this:

      def function_name(args, opts \\ []])

  And then you're all set to actually write the meat of your function. (You of
  course don't need a function head if your function only consists of one clause.)

      def function_name(args, opts) do
        # This validates and merges the options, throwing on error.
        opts = Crutches.Options.combine!(opts, @function_name)

        # You can now use the options.
        do_something_with(opts[:foo])
      end
  """

  @type key :: atom
  @type value :: any

  @type t :: [{key, value}]
  @type t(value) :: [{key, value}]

  @type ok(value) :: {:ok, value}
  @type error ::{:error, any}

  @doc """
  Validates the `opts` keyword list according to `config`, combines defaults.

  For intended use see the module documentation.

  # Config variable

  The `config` parameter should be a keyword list with the following keys:

    - `:valid` ([atom]) --- Parameters that your function accepts.
    - `:defaults` ([atom: any]) --- Default values for the options in `:valid`.

  Returns `{:ok, opts}` on succes, `{:error, invalid_keys}` on failure.

  # Examples

      iex> config = [valid: ~w(foo bar)a, defaults: [foo: "some", bar: "value"]]
      iex> Option.combine([foo: "another"], config)
      {:ok, [foo: "another", bar: "value"]}

      iex> config = [valid: ~w(bar baz)a, defaults: [bar: "good", baz: "values"]]
      iex> Option.combine([boom: "this blows up"], config)
      {:error, [:boom]}

  """
  @spec combine(t, t([atom]) | t(t)) :: ok(t) | error
  def combine(opts, config) do
    combine(opts, config, &Elixir.Keyword.merge(&1, &2))
  end

  @doc """
  This function is the same as `combine/2`, except it returns `options` on
  validation succes and throws `ArgumentError` on validation failure.

  # Examples

      iex> config = [valid: ~w(foo bar)a, defaults: [foo: "some", bar: "value"]]
      iex> Option.combine!([foo: "another"], config)
      [foo: "another", bar: "value"]

      iex> config = [valid: ~w(bar baz)a, defaults: [bar: "good", baz: "values"]]
      iex> Option.combine!([boom: "this blows up"], config)
      ** (ArgumentError) invalid key boom

  """
  @spec combine!(t, t([atom]) | t(t)) :: t
  def combine!(opts, config) do
    combine!(opts, config, &Elixir.Keyword.merge(&1, &2))
  end

  @doc """
  Validate `opts` according to `config`, combines according to `combinator`

  Behavior is the same as `combine/2`, except that you can specify how `opts`
  and `config[:defaults]` are merged by passing a `combinator` function.

  This function should combine the two keyword lists into one. It receives
  `config[:defaults]` as the first parameter and the validated `opts` as the
  second.

  # Examples

  Contrived example showing of the use of `combinator`.

      iex> config = [valid: ~w(foo bar)a, defaults: [foo: "some", bar: "value"]]
      iex> combinator = fn(_, _) -> nil end
      iex> Option.combine([foo: "again"], config, combinator)
      {:ok, nil}

  """
  @spec combine(t, t | t(t), (t, t -> t)) :: ok(t) | error
  def combine(opts, config, combinator) do
    case validate(opts, config[:valid]) do
      {:ok, _} -> {:ok, combinator.(config[:defaults], opts)}
      {:error, invalid} -> {:error, invalid}
    end
  end

  @doc ~S"""
  Throwing version of `combine/3`

  # Examples

      iex> config = [valid: ~w(foo bar)a, defaults: [foo: "some", bar: "value"]]
      iex> combinator = fn(_, _) -> nil end
      iex> Option.combine!([baz: "fail"], config, combinator)
      ** (ArgumentError) invalid key baz
  """
  @spec combine!(t, t | t(t), (t, t -> t)) :: t
  def combine!(opts, config, combinator) do
    case combine(opts, config, combinator) do
      {:ok, opts} -> opts
      {:error, invalid} ->
        invalid = invalid |> Enum.join(" ")
        raise ArgumentError, message: "invalid key #{invalid}"
    end
  end

  @doc ~S"""
  Checks a `opts` for keys not in `valid`.

  Returns {:ok, []} if all options are kosher, otherwise {:error, list},
  where list is a list of all invalid keys.

  # Examples

      iex> Option.validate([good: "", good_opt: ""], [:good, :good_opt])
      {:ok, []}

      iex> Option.validate([good: "", bad: ""], [:good])
      {:error, [:bad]}

  """
  @spec validate(t, [atom]) :: ok([]) | error
  def validate(opts, valid) do
    if Enum.empty?(invalid_options(opts, valid)) do
      {:ok, []}
    else
      {:error, invalid_options(opts, valid)}
    end
  end

  @doc ~S"""
  Throwing version of `Option.validate`

  # Examples

      iex> Option.validate!([good: "", bad: ""], [:good])
      ** (ArgumentError) invalid key bad

      iex> Option.validate!([good: "", bad: "", worse: ""], [:good])
      ** (ArgumentError) invalid key bad, worse

      iex> Option.validate!([good: ""], [:good])
      true
  """
  @spec validate!(t, [atom]) :: true
  def validate!(opts, valid) do
    case validate(opts, valid) do
      {:ok, _} -> true
      {:error, invalid_options} ->
        raise ArgumentError, "invalid key " <> Enum.join(invalid_options, ", ")
    end
  end

  @doc ~S"""
  Check `opts` for keys not in `valid`.

  Return `false` when a bad key is found, otherwise return `true`.

  # Examples

      iex> Option.all_valid?([good: "", good_opt: ".", bad: "!"], [:good, :good_opt])
      false

      iex> Option.all_valid?([good: "", good_opt: "."], [:good, :good_opt])
      true
  """
  @spec all_valid?(t, [atom]) :: boolean
  def all_valid?(opts, valid) do
    Enum.empty?(invalid_options(opts, valid))
  end

  defp invalid_options(opts, valid) do
    opts
    |> Keyword.keys
    |> Enum.reject(& &1 in valid)
  end
end
