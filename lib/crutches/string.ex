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
end
