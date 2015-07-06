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

  #Switch parameter order so we can use the pipe operator.
  defp regex_replace(string, regex, replace) do
    Regex.replace(regex, string, replace)
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

  """
  def from(str, starting_point) when starting_point >= 0 do
    from_point(str, starting_point)
  end

  def from(str, starting_point) when starting_point < 0 do
    from_point(str, String.length(str) + starting_point)
  end

  defp from_point(str, point) do
    to_string(Enum.map(point..String.length(str) - 1, &String.at(str, &1)))
  end
end
