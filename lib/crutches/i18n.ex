defmodule Crutches.I18n do
  use Linguist.Vocabulary

  def load(locale) when is_binary(locale) do
    [document|_] =
      Path.join([__DIR__, "..", "..", "config", "locale", "#{locale}.yml"])
      |> :yamerl_constr.file
    :proplists.get_value(String.to_char_list(locale), document)
  end
end