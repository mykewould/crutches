defmodule Crutches.String do
  import String, only: [
    replace: 3,
    downcase: 1,
    split: 2,
    capitalize: 1,
    slice: 2,
    strip: 1
  ]

  @type t :: String
  @doc ~S"""
  Makes an underscored, lowercase form from the expression in the string.
  +underscore+ will also change '.' to '/' to convert namespaces to paths.

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
  @spec underscore(t) :: t
  def underscore(camel_case) do
    camel_case
    |> replace(~r/\./, "/")
    |> replace(~r/([A-Z]+)([A-Z][a-z])/, "\\1_\\2")
    |> replace(~r/([a-z\d])([A-Z])/, "\\1_\\2")
    |> replace(~r/-/, "_")
    |> downcase
  end

  @doc ~S"""
  Converts strings to UpperCamelCase.

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
  @spec camelize(t) :: t
  def camelize(underscore) do
    underscore
    |> split("_")
    |> Enum.map(&capitalize/1)
    |> Enum.reduce(&(&2 <> &1))
  end

  # Access

  @doc ~S"""
  Returns a substring from the given position to the end of the string.
  If the position is negative, it is counted from the end of the string.

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
  @spec from(t, Integer.t) :: t
  def from(string, start) when start >= 0 do
    slice(string, start..(String.length(string) - 1))
  end

  def from(string, start) when start < 0 do
    new_start = String.length(string) + start
    case new_start < 0 do
      true  -> ""
      false -> slice(string, new_start..(String.length(string) - 1))
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
  @spec to(t, Integer.t) :: t
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
  @spec squish(t) :: t
  def squish(string) do
    string |> replace(~r/[[:space:]]+/, " ") |> strip
  end

  @doc ~S"""
  Returns a new string with all occurrences of the patterns removed.

  ## Examples
      iex> String.remove("foo bar test", " test")
      "foo bar"

      iex> String.remove("foo bar test", ~r/foo /)
      "bar test"

      iex> String.remove("foo bar test", [~r/foo /, " test"])
      "bar"
  """
  @spec remove(t, t | Regex.t | List.t) :: t
  def remove(string, to_remove) when is_list(to_remove) do
    to_remove |> Enum.reduce(string, &remove(&2, &1))
  end

  def remove(string, to_remove) do
    replace(string, to_remove, "")
  end
end
