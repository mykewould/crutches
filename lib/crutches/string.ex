defmodule Crutches.String do
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
    |> regex_replace(~r/\./, "/")
    |> regex_replace(~r/([A-Z]+)([A-Z][a-z])/, "\\1_\\2")
    |> regex_replace(~r/([a-z\d])([A-Z])/, "\\1_\\2")
    |> regex_replace(~r/-/, "_")
    |> String.downcase
  end

  # Switch parameter order so we can use the pipe operator.
  defp regex_replace(string, regex, replace) do
    Regex.replace(regex, string, replace)
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
    |> String.split("_")
    |> Enum.map(&String.capitalize(&1))
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
      iex> str = "hello"
      iex> |> String.from(0)
      iex> |> String.to(-1)
      "hello"

      iex> str = "hello"
      iex> |> String.from(1)
      iex> |> String.to(-2)
      "ell"

      iex> str = "a"
      iex> |> String.from(1)
      iex> |> String.to(1500)
      ""

      iex> str = "elixir"
      iex> |> String.from(-10)
      iex> |> String.to(-7)
      ""
  """
  @spec from(t, Integer.t) :: t
  def from(str, start) when start >= 0 do
    String.slice(str, start..(String.length(str) - 1))
  end

  def from(str, start) when start < 0 do
    new_start  = String.length(str) + start
    case new_start < 0 do
      true  -> ""
      false -> String.slice(str, new_start..(String.length(str) - 1))
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
      iex> str = "hello"
      iex> |> String.from(0)
      iex> |> String.to(-1)
      "hello"

      iex> str = "hello"
      iex> |> String.from(1)
      iex> |> String.to(-2)
      "ell"
  """
  @spec to(t, Integer.t) :: t
  def to(str, length) when length >= 0 do
    String.slice(str, 0..length)
  end

  def to(str, length) when length < 0 do
    String.slice(str, 0..(String.length(str) + length))
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
  def squish(str) do
    Regex.replace(~r/[[:space:]]+/, str, " ")
    |> String.strip
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
  def remove(str, str_to_rm) when is_list(str_to_rm) == false do
    String.replace(str, str_to_rm, "")
  end

  def remove(str, removeables) when is_list(removeables) do
    Enum.reduce(removeables, str, &(remove(&2, &1)))
  end
end
