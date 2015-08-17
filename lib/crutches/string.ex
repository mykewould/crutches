defmodule Crutches.String do
  import String, only: [
    replace: 3,
    downcase: 1,
    split: 2,
    capitalize: 1,
    slice: 2,
    strip: 1
  ]

  @moduledoc ~s"""
  Convenience functions for strings.

  This module provides several convenience functions operating on strings.
  Simply call any function (with any options if applicable) to make use of it.
  """

  @doc ~S"""
  Converts a `string` to `snake_case`.

  `underscore/1` also changes `.` to `/` to convert namespaces into paths.


  ## Examples

      iex> String.underscore("Product")
      "product"

      iex> String.underscore("SpecialGuest")
      "special_guest"

      iex> String.underscore("ApplicationController")
      "application_controller"

      iex> String.underscore("Area51Controller")
      "area51_controller"

      ["HTMLTidyGenerator",  "html_tidy_generator"],

      ["UsersSection.Commission.Department", "users_section/commission/department"],

  """
  defdelegate underscore(string), to: Mix.Utils

  @doc ~S"""
  Converts `string` to CamelCase.

  ## Examples

      iex> String.camelize("product")
      "Product"

      iex> String.camelize("special_guest")
      "SpecialGuest"

      iex> String.camelize("application_controller")
      "ApplicationController"

      iex> String.camelize("area51_controller")
      "Area51Controller"

  """
  defdelegate camelize(string), to: Mix.Utils

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
  @spec from(String.t, integer) :: String.t
  def from(string, position) when position >= 0 do
    slice(string, position..(String.length(string) - 1))
  end

  def from(string, position) when position < 0 do
    new_position = String.length(string) + position
    case new_position < 0 do
      true  -> ""
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
  @spec to(String.t, integer) :: String.t
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
  @spec squish(String.t) :: String.t
  def squish(string) do
    string |> replace(~r/[[:space:]]+/, " ") |> strip
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
  @spec remove(String.t, String.t | Regex.t | list(any)) :: String.t
  def remove(string, patterns) when is_list(patterns) do
    patterns |> Enum.reduce(string, &remove(&2, &1))
  end

  def remove(string, pattern) do
    replace(string, pattern, "")
  end
end
