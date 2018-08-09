defmodule Crutches.String do
  alias Crutches.Option

  import String,
    only: [
      replace: 3,
      slice: 2,
      trim: 1
    ]

  @moduledoc ~s"""
  Convenience functions for strings.

  This module provides several convenience functions operating on strings.
  Simply call any function (with any options if applicable) to make use of it.
  """

  # Access

  @doc ~S"""
  Gives a substring of `string` from the given `position`.

  If `position` is positive, counts from the start of the string.
  If `position` is negative, count from the end of the string.

  ## Examples
      iex> String.from("hello", 0)
      "hello"

      iex> String.from("hello", 3)
      "lo"

      iex> String.from("hello", -2)
      "lo"

      iex> String.from("hello", -7)
      ""

  You can mix it with +to+ method and do fun things like:

      iex> "hello"
      iex> |> String.from(0)
      iex> |> String.to(-1)
      "hello"

      iex> "hello"
      iex> |> String.from(1)
      iex> |> String.to(-2)
      "ell"

      iex> "a"
      iex> |> String.from(1)
      iex> |> String.to(1500)
      ""

      iex> "elixir"
      iex> |> String.from(-10)
      iex> |> String.to(-7)
      ""
  """
  @spec from(String.t(), integer) :: String.t()
  def from(string, position) when position >= 0 do
    slice(string, position..(String.length(string) - 1))
  end

  def from(string, position) when position < 0 do
    new_position = String.length(string) + position

    case new_position < 0 do
      true -> ""
      false -> slice(string, new_position..(String.length(string) - 1))
    end
  end

  @doc ~S"""
  Returns a substring from the beginning of the string to the given position.
  If the position is negative, it is counted from the end of the string.

  ## Examples
      iex> String.to("hello", 0)
      "h"

      iex> String.to("hello", 3)
      "hell"

      iex> String.to("hello", -2)
      "hell"

  You can mix it with +from+ method and do fun things like:
      iex> "hello"
      iex> |> String.from(0)
      iex> |> String.to(-1)
      "hello"

      iex> "hello"
      iex> |> String.from(1)
      iex> |> String.to(-2)
      "ell"
  """
  @spec to(String.t(), integer) :: String.t()
  def to(string, length) when length >= 0 do
    slice(string, 0..length)
  end

  def to(string, length) when length < 0 do
    slice(string, 0..(String.length(string) + length))
  end

  # Filters

  @doc ~S"""
  Returns the string, first removing all whitespace on both ends of
  the string, and then changing remaining consecutive whitespace
  groups into one space each.

  ## Examples
      iex> str = "A multi line
      iex> string"
      iex> String.squish(str)
      "A multi line string"

      iex> str = " foo   bar    \n   \t   boo"
      iex> String.squish(str)
      "foo bar boo"
  """
  @spec squish(String.t()) :: String.t()
  def squish(string) do
    string |> replace(~r/[[:space:]]+/, " ") |> trim
  end

  @doc ~S"""
  Remove all occurrences of `pattern` from `string`.

  Can also take a list of `patterns`.

  ## Examples
      iex> String.remove("foo bar test", " test")
      "foo bar"

      iex> String.remove("foo bar test", ~r/foo /)
      "bar test"

      iex> String.remove("foo bar test", [~r/foo /, " test"])
      "bar"
  """
  @spec remove(String.t(), String.t() | Regex.t() | list(any)) :: String.t()
  def remove(string, patterns) when is_list(patterns) do
    patterns |> Enum.reduce(string, &remove(&2, &1))
  end

  def remove(string, pattern) do
    replace(string, pattern, "")
  end

  @doc ~S"""
  Capitalizes every word in a string. Similar to ActiveSupport's #titleize.

    iex> String.titlecase("the truth is rarely pure and never simple.")
    "The Truth Is Rarely Pure And Never Simple."
    iex> String.titlecase("THE TRUTH IS RARELY PURE AND NEVER SIMPLE.")
    "The Truth Is Rarely Pure And Never Simple."
    iex> String.titlecase("the truth is rarely pure and NEVER simple.")
    "The Truth Is Rarely Pure And Never Simple."
  """
  @spec titlecase(String.t()) :: String.t()
  def titlecase(string) when is_binary(string) do
    string
    |> String.split(" ")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end

  @doc ~S"""
  Truncates a given `text` after a given `length` if `text` is longer than `length`:

  Truncates a given text after a given `len`gth if text is longer than `len`th.
  The last characters will be replaced with the `:omission` (defaults to “...”) for a total length not exceeding `len`.

  Pass a `:separator` to truncate text at a natural break (the first occurence of that separator before the provided length).

  ## Examples

      iex> String.truncate("Once upon a time in a world far far away", 27)
      "Once upon a time in a wo..."

      iex> String.truncate("Once upon a time in a world far far away", 27, separator: " ")
      "Once upon a time in a..."

      iex> String.truncate("Once upon a time in a world far far away", 27, separator: ~r/\s/)
      "Once upon a time in a..."

      iex> String.truncate("Once upon a time in a world far far away", 35, separator: "far ")
      "Once upon a time in a world far..."

      iex> String.truncate("And they found that many people were sleeping better.", 25, omission: "... (continued)")
      "And they f... (continued)"

      iex> String.truncate("Supercalifragilisticexpialidocious", 24, separator: ~r/\s/)
      "Supercalifragilistice..."
  """
  @truncate [
    valid: ~w(separator omission)a,
    defaults: [
      separator: nil,
      omission: "..."
    ]
  ]
  def truncate(string, len, opts \\ [])

  def truncate(string, len, opts) when is_binary(string) and is_integer(len) do
    opts = Option.combine!(opts, @truncate)

    if String.length(string) > len do
      length_with_room = len - String.length(opts[:omission])
      do_truncate(string, length_with_room, opts[:separator], opts[:omission])
    else
      string
    end
  end

  defp do_truncate(string, length, sep, omission) when is_nil(sep) do
    String.slice(string, 0, length) <> omission
  end

  defp do_truncate(string, length, sep, omission) when is_binary(sep) do
    sep_size = String.length(sep)

    chunk_indexes =
      string
      |> String.codepoints()
      |> Enum.take(length)
      |> Enum.with_index()
      |> Enum.chunk(sep_size, sep_size, [])
      |> Enum.reverse()
      |> Enum.find(fn chars ->
        str = chars |> Enum.map(&elem(&1, 0)) |> Enum.join("")
        str == sep
      end)

    {_, index} = if chunk_indexes, do: List.last(chunk_indexes), else: {nil, length}

    do_truncate(string, index, nil, omission)
  end

  defp do_truncate(string, length, sep, omission) do
    case Regex.scan(sep, string, return: :index) do
      [_ | _] = captures ->
        [{index, _}] = captures |> Enum.reverse() |> Enum.find(fn [{i, _}] -> i <= length end)
        do_truncate(string, index, nil, omission)

      [] ->
        do_truncate(string, length, nil, omission)
    end
  end
end
