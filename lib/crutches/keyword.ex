defmodule Crutches.Keyword do
  @doc ~S"""
  Checks a keyword list for unexpected keys, by using a default list of keys.
  When a bad key is detected it returns false, else it returns true.

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
    Enum.empty?(invalid_options)
  end

  @doc ~S"""
  Checks a keyword list for unexpected keys, by using a default list of keys.
  Returns {:ok, []} if all options are kosher, otherwise {:error, list},
  where list is a list of all invalid keys.

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
    if Enum.empty?(invalid_options) do
      {:ok, []}
    else
      {:error, invalid_options}
    end
  end

  @doc ~S"""
  Throwing version of Keyword.validate_keys

  ## Examples

      iex> Keyword.validate_keys!([good: "", bad: ""], [:good])
      ** (ArgumentError) invalid key bad

      iex> Keyword.validate_keys!([good: "", bad: "", worse: ""], [:good])
      ** (ArgumentError) invalid key bad, worse

      iex> Keyword.validate_keys!([good: ""], [:good])
      true
  """
  def validate_keys!(options, whitelist) do
    if all_keys_valid?(options, whitelist) do
      true
    else
      {:error, invalid_options} = validate_keys(options, whitelist)
      raise ArgumentError, "invalid key " <> Enum.join(invalid_options, ", ")
    end
  end
end