defmodule Crutches.Helpers.Number do
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

  @doc ~s"""
    Formats a +number+ into a US phone number (e.g., (555) 123-9876).
    You can customize the format in the +options+ hash.

    iex> Number.number_to_phone(5551234)
    "555-1234"

    iex> Number.number_to_phone("5551234")
    "555-1234"

    iex> Number.number_to_phone(1235551234)
    "123-555-1234"

    iex> Number.number_to_phone(1235551234, area_code: true)
    "(123) 555-1234"

    iex> Number.number_to_phone(12345551234, area_code: true)
    "1(234) 555-1234"

    iex> Number.number_to_phone(1235551234, delimiter: " ")
    "123 555 1234"

    iex> Number.number_to_phone(1235551234, area_code: true, extension: 555)
    "(123) 555-1234 x 555"

    iex> Number.number_to_phone(1235551234, country_code: 1)
    "+1-123-555-1234"

    iex> Number.number_to_phone('123a456')
    "123a456"

    iex> Number.number_to_phone(1235551234, country_code: 1, extension: 1343, delimiter: ".")
    "+1.123.555.1234 x 1343"

    iex> Number.number_to_phone(1235551234, unsupported_option: "some_value")
    ** (ArgumentError) invalid key unsupported_option
  """
  @number_to_phone [
    valid_options: [:area_code, :delimiter, :extension, :country_code],
    default_options: [
      area_code: false,
      delimiter: "-",
      extension: nil,
      country_code: nil
    ]
  ]

  def number_to_phone(number, opts \\ [])
  def number_to_phone(number, opts) when is_list(number) do
    number |> to_string |> number_to_phone(opts)
  end
  def number_to_phone(number, opts) when is_binary(number) do
    case Integer.parse(number) do
      {integer, ""} -> number_to_phone integer, opts
      _             -> number
    end
  end
  def number_to_phone(number, opts) when is_integer(number) do
    Crutches.Keyword.validate_keys! opts, @number_to_phone[:valid_options]
    opts = Keyword.merge @number_to_phone[:default_options], opts
    delimiter = to_string opts[:delimiter]

    Integer.to_string(number)
    |> split_for_phone
    |> join_as_phone(delimiter, opts[:area_code])
    |> add_extension(opts[:extension])
    |> add_country_code(opts[:country_code], delimiter)
  end

  defp split_for_phone(safe_string) when byte_size(safe_string) < 7 do
    [safe_string]
  end
  defp split_for_phone(safe_string) when byte_size(safe_string) === 7 do
    safe_string |> String.split_at(3) |> Tuple.to_list
  end
  defp split_for_phone(safe_string) when byte_size(safe_string) > 7 do
    {first, last} = String.split_at(safe_string, -4)
    {first, second} = String.split_at(first, -3)
    [first, second, last]
  end

  defp join_as_phone([area_code, second, last], delimiter, true) when byte_size(area_code) <= 3 do
    "(#{area_code}) " <> join_as_phone([second, last], delimiter, true)
  end
  defp join_as_phone([first, second, last], delimiter, true) when byte_size(first) > 3 do
    {first_split, area_code} = String.split_at(first, -3)
    "#{first_split}(#{area_code}) " <> join_as_phone([second, last], delimiter, true)
  end
  defp join_as_phone(phone_components, delimiter, _) do
    phone_components |> Enum.join(delimiter)
  end

  defp add_extension(phone_number, nil), do: phone_number
  defp add_extension(phone_number, extension) do
    phone_number <> " x #{extension}"
  end

  defp add_country_code(phone_number, nil, _), do: phone_number
  defp add_country_code(phone_number, country_code, delimiter) do
    "+#{country_code}#{delimiter}" <> phone_number
  end
end
