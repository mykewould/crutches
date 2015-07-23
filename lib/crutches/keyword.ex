defmodule Crutches.Keyword do
  require Logger

  @doc ~S"""
  Checks a keyword list for unexpected keys, by using a default list of keys. When a bad key is detected it returns false, else it returns true.

  ## Examples

      iex> Keyword.all_keys_valid?([good: "", good_opt: ".", bad: "!"], [:good, :good_opt])
      false

      iex> Keyword.all_keys_valid?([good: "", good_opt: "."], [:good, :good_opt])
      true
  """
  def all_keys_valid?(options, whitelist) do
    invalid_options =
      options
      |> Stream.reject(fn {option, _} -> option in whitelist end)
      |> Stream.take(1)
    !Enum.any?(invalid_options)
  end
end