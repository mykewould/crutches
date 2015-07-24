defmodule Crutches.Helpers.Number do
  require Logger

  @doc ~s"""
  Formats a number with grouped thousands (e.g. 1,234)

      iex> Number.to_delimited(12345678)
      "12,345,678"

      iex> Number.to_delimited("123456")
      "123,456"

      iex> Number.to_delimited(12345678.05)
      "12,345,678.05"

      iex> Number.to_delimited(12345678, delimiter: '.')
      "12.345.678"

      iex> Number.to_delimited(12345678, delimiter: ',')
      "12,345,678"

      iex> Number.to_delimited(12345678.05, separator: ' ')
      "12,345,678 05"

      iex> Number.to_delimited(98765432.98, delimiter: ' ', separator: ',')
      "98 765 432,98"
  """
  @to_delimited [
    valid_options: [:delimiter, :separator],
    default_options: [
      delimiter: ',',
      separator: '.'
    ]
  ]

  def to_delimited(number, provided_options \\ [])

  def to_delimited(number, provided_options) when is_binary(number) do
    Crutches.Keyword.validate_keys!(provided_options, @to_delimited[:valid_options])

    options = Keyword.merge(@to_delimited[:default_options], provided_options)
    decimal_separator = to_string(@to_delimited[:default_options][:separator])

    if String.contains?(number, decimal_separator) do
      [number, decimal] = String.split(number, decimal_separator)
      format_number(number, options) <> to_string(options[:separator]) <> decimal
    else
      format_number(number, options)
    end
  end

  def to_delimited(number, provided_options) do
    number |> to_string |> to_delimited(provided_options)
  end

  defp format_number(number, options) do
    {formatted_number, _} =
      number
      |> to_char_list
      |> tl
      |> Enum.reverse
      |> Enum.reduce {[], 1}, fn (char, {buffer, counter}) ->
        if rem(counter, 3) == 0 do
          {[options[:delimiter] | [char | buffer]], 1}
        else
          {[char | buffer], counter + 1}
        end
      end
    String.first(number) <> List.to_string(formatted_number)
  end
end