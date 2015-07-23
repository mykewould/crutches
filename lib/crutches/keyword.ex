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

  @doc ~S"""
  Checks a keyword list for unexpected keys, by using a default list of keys. Return {:ok, []} if all options are kosher, otherwise {:error, list}, where list is a list of all invalid keys.

  ## Examples

      iex> Keyword.validate_keys([good: "", good_opt: ""], [:good, :good_opt])
      {:ok, []}

      iex> Keyword.validate_keys([good: "", bad: ""], [:good])
      {:error, [:bad]}

  """
  def validate_keys(options, whitelist) do
    invalid_options =
      options
      |> Enum.reject(fn {option, _} -> option in whitelist end)
      |> Keyword.keys
    if Enum.any?(invalid_options) do
      {:error, invalid_options}
    else
      {:ok, []}
    end
  end
end