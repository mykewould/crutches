defmodule Crutches.String do
  def underscore(camel_case_string) do
    camel_case_string
      |> regex_replace(~r/\./, "/")
      |> regex_replace(~r/([A-Z]+)([A-Z][a-z])/, "\\1_\\2")
      |> regex_replace(~r/([a-z\d])([A-Z])/, "\\1_\\2")
      |> regex_replace(~r/-/, "_")
      |> String.downcase
  end

  defp regex_replace(string, regex, replace) do
    Regex.replace(regex, string, replace)
  end
end
