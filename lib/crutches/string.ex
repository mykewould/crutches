defmodule Crutches.String do
  def underscore(camel_case) do
    camel_case
      |> regex_replace(~r/\./, "/")
      |> regex_replace(~r/([A-Z]+)([A-Z][a-z])/, "\\1_\\2")
      |> regex_replace(~r/([a-z\d])([A-Z])/, "\\1_\\2")
      |> regex_replace(~r/-/, "_")
      |> String.downcase
  end

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

  # Returns a substring from the given position to the end of the string.
  # If the position is negative, it is counted from the end of the string.
  #
  #   str = "hello"
  #   String.from(str, 0)  # => "hello"
  #   String.from(str, 3)  # => "lo"
  #   String.from(str, -2) # => "lo"
  def from(str, starting_point) when starting_point >= 0 do
    from_point(str, starting_point)
  end

  def from(str, starting_point) when starting_point < 0 do
    from_point(str, String.length(str) + starting_point)
  end

  defp from_point(str, point) do
    to_string Enum.map point..String.length(str) - 1, fn(int) ->
      String.at(str, int)
    end
  end
end
