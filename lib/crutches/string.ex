defmodule Crutches.String do
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

  """
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
      iex> str = "hello"
      iex> String.from(str, 0)
      "hello"
      iex> String.from(str, 3)
      "lo"
      iex> String.from(str, -2)
      "lo"

  You can mix it with +to+ method and do fun things like:
      iex> str = "hello"
      iex> |> String.from(0)
      iex> |> String.to(-1)
      "hello"
      iex> str
      iex> |> String.from(1)
      iex> |> String.to(-2)
      "ell"
  """
  def from(str, starting_point) when starting_point >= 0 do
    from_to(str, starting_point, String.length(str) - 1)
  end

  def from(str, starting_point) when starting_point < 0 do
    new_starting_point  = String.length(str) + starting_point
    from_to(str, new_starting_point, String.length(str) - 1)
  end

  @doc ~S"""
  Returns a substring from the beginning of the string to the given position.
  If the position is negative, it is counted from the end of the string.

  ## Examples
      iex> str = "hello"
      iex> String.to(str, 0)
      "h"
      iex> String.to(str, 3)
      "hell"
      iex> String.to(str, -2)
      "hell"

  You can mix it with +from+ method and do fun things like:
      iex> str = "hello"
      iex> |> String.from(0)
      iex> |> String.to(-1)
      "hello"
      iex> str
      iex> |> String.from(1)
      iex> |> String.to(-2)
      "ell"
  """
  def to(str, end_point) when end_point >= 0 do
    from_to(str, 0, end_point)
  end

  def to(str, end_point) when end_point < 0 do
    from_to(str, 0, String.length(str) + end_point)
  end

  defp from_to(str, start_point, end_point) do
    to_string(Enum.map(start_point..end_point, &String.at(str, &1)))
  end
end
