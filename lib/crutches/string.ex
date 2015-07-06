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
    array = underscore
    |> String.split("_")
    |> Enum.map fn(word) -> String.capitalize(word) end
    array |> Enum.reduce fn(x, acc) ->  acc <> x end
    #Not sure why we can't use the pipe directly from
    #Enum.map, but it throws an error.
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
  def from(str, starting_point) do
    if starting_point < 0 do
      new_point = String.length(str) + starting_point
    else
      new_point = starting_point
    end
    length = String.length(str) - 1
    char_arr = Enum.map new_point..length, fn(int) ->
      String.at(str, int)
    end
    to_string(char_arr)
  end
end
