defmodule Crutches.Format.Number do
  @doc ~s"""
  Formats a number with grouped thousands (e.g. 1,234)

      iex> Number.as_delimited(12345678)
      "12,345,678"

      iex> Number.as_delimited("123456")
      "123,456"

      iex> Number.as_delimited(12345678.05)
      "12,345,678.05"

      iex> Number.as_delimited(12345678, delimiter: ".")
      "12.345.678"

      iex> Number.as_delimited(12345678, delimiter: ",")
      "12,345,678"

      iex> Number.as_delimited(12345678.05, separator: " ")
      "12,345,678 05"

      iex> Number.as_delimited(98765432.98, delimiter: " ", separator: ",")
      "98 765 432,98"
  """
  @as_delimited [
    valid: [:delimiter, :separator],
    defaults: [
      delimiter: ",",
      separator: "."
    ]
  ]

  def as_delimited(number, opts \\ @as_delimited[:defaults])
  def as_delimited(number, opts) when is_binary(number) do
    opts = Crutches.Option.combine!(opts, @as_delimited)

    if String.contains?(number, ".") do
      [number, decimal] = String.split(number, ".")
      format_number(number, opts) <> opts[:separator] <> decimal
    else
      format_number(number, opts)
    end
  end
  def as_delimited(number, opts) do
    number |> to_string |> as_delimited(opts)
  end

  defp format_number(number, opts) do
    delimiter = to_char_list(opts[:delimiter])

    number
    |> to_char_list
    |> Enum.reverse
    |> Enum.chunk(3, 3, [])
    |> Enum.map(&Enum.reverse/1)
    |> Enum.intersperse(delimiter)
    |> Enum.reverse
    |> to_string
  end

  @doc ~s"""
    Formats a +number+ into a US phone number (e.g., (555) 123-9876).
    You can customize the format in the +options+ hash.

    iex> Number.as_phone(5551234)
    "555-1234"

    iex> Number.as_phone("5551234")
    "555-1234"

    iex> Number.as_phone(1235551234)
    "123-555-1234"

    iex> Number.as_phone(1235551234, area_code: true)
    "(123) 555-1234"

    iex> Number.as_phone(12345551234, area_code: true)
    "1(234) 555-1234"

    iex> Number.as_phone(1235551234, delimiter: " ")
    "123 555 1234"

    iex> Number.as_phone(1235551234, area_code: true, extension: 555)
    "(123) 555-1234 x 555"

    iex> Number.as_phone(1235551234, country_code: 1)
    "+1-123-555-1234"

    iex> Number.as_phone('123a456')
    "123a456"

    iex> Number.as_phone(1235551234, country_code: 1, extension: 1343, delimiter: ".")
    "+1.123.555.1234 x 1343"

    iex> Number.as_phone(1235551234, unsupported_option: "some_value")
    ** (ArgumentError) invalid key unsupported_option
  """
  @as_phone [
    valid_options: [:area_code, :delimiter, :extension, :country_code],
    default_options: [
      area_code: false,
      delimiter: "-",
      extension: nil,
      country_code: nil
    ]
  ]

  def as_phone(number, opts \\ [])
  def as_phone(number, opts) when is_list(number) do
    number |> to_string |> as_phone(opts)
  end
  def as_phone(number, opts) when is_binary(number) do
    case Integer.parse(number) do
      {integer, ""} -> as_phone integer, opts
      _             -> number
    end
  end
  def as_phone(number, opts) when is_integer(number) do
    Crutches.Option.validate! opts, @as_phone[:valid_options]
    opts = Keyword.merge @as_phone[:default_options], opts
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

  @doc ~s"""
    Formats a `number` into a currency string (e.g., $13.65). You can customize the format in
    the `options` hash. The `as_currency!` method raises an exception if the input is
    not numeric

    # Options

     * `:locale` - Sets the locale to be used for formatting (defaults to current locale) *** Not implemented ***.
     * `:precision` - Sets the level of precision (defaults to 2).
     * `:unit` - Sets the denomination of the currency (defaults to “$”).
     * `:separator` - Sets the separator between the units (defaults to “.”).
     * `:delimiter` - Sets the thousands delimiter (defaults to “,”).
     * `:format` - Sets the format for non-negative numbers (defaults to “%u%n”). Fields are %u for the currency, and %n for the number.
     * `:negative_format` - Sets the format for negative numbers (defaults to prepending an hyphen to the formatted number given by :format). Accepts the same fields than :format, except %n is here the absolute value of the number.


    iex> Number.as_currency(1234567890.50)
    "$1,234,567,890.50"

    iex> Number.as_currency(1234567890.506)
    "$1,234,567,890.51"

    iex> Number.as_currency(1234567890.506, precision: 3)
    "$1,234,567,890.506"

    iex> Number.as_currency(1234567890.506, locale: :fr)
    "$1,234,567,890.51"

    iex> Number.as_currency("123a456")
    "$123a456"

    iex> Number.as_currency(-1234567890.50, negative_format: "(%u%n)")
    "($1,234,567,890.50)"

    iex> Number.as_currency(1234567890.50, unit: "&pound;", separator: ",", delimiter: "")
    "&pound;1234567890,50"

    iex> Number.as_currency(1234567890.50, unit: "&pound;", separator: ",", delimiter: "", format: "%n %u")
    "1234567890,50 &pound;"

    iex> Number.as_currency(1235551234, unsupported_option: "some_value")
    ** (ArgumentError) invalid key unsupported_option

    iex> Number.as_currency!("123a456")
    ** (ArithmeticError) bad argument in arithmetic expression
  """

  @as_currency [
    valid_options: [:locale, :precision, :unit, :separator, :delimiter, :format, :negative_format],
    default_options: [
      locale: :en,
      precision: 2,
      unit: "$",
      separator: ".",
      delimiter: ",",
      format: "%u%n",
      negative_format: "-%u%n"
    ]
  ]

  def as_currency!(number, opts \\ @as_currency[:default_options])
  def as_currency!(number, opts) when is_binary(number) do
    case Float.parse(number) do
      {float, ""} -> as_currency float, opts
      _           -> raise ArithmeticError
    end
  end
  def as_currency!(number, opts) do
    as_currency number, opts
  end

  def as_currency(number, opts \\ @as_currency[:default_options])
  def as_currency(number, opts) when is_binary(number) do
    case Float.parse(number) do
      {float, ""} -> as_currency float, opts
      _           -> format_as_currency number, opts[:unit], opts[:format]
    end
  end
  def as_currency(number, opts) when is_number(number) do
    Crutches.Option.validate! opts, @as_currency[:valid_options]
    opts = Keyword.merge @as_currency[:default_options], opts

    format = number < 0 && opts[:negative_format] || opts[:format]

    abs(number/1)
    |> Float.to_string(decimals: opts[:precision])
    |> as_delimited(delimiter: opts[:delimiter], separator: opts[:separator])
    |> format_as_currency(opts[:unit], format)
  end

  defp format_as_currency(binary, unit, format) when is_binary(binary) do
    format
    |> String.replace("%n", String.lstrip(binary, ?-), global: false)
    |> String.replace("%u", unit)
  end

  @doc ~S"""
    Formats a `number` as a percentage string (e.g., 65%). You can customize the
    format in the `options` Dict

    The `as_percentage!` method raises an error if the input is not numeric.

    # Options

     * `:locale` - Sets the locale to be used for formatting (defaults to current locale).
     * `:precision` - Sets the precision of the number (defaults to 3).
     * `:significant` - If true, precision will be the # of significant_digits. If false, the # of fractional digits (defaults to false).
     * `:separator` - Sets the separator between the fractional and integer digits (defaults to “.”).
     * `:delimiter` - Sets the thousands delimiter (defaults to “”).
     * `:strip_insignificant_zeros` - If true removes insignificant zeros after the decimal separator (defaults to false).
     * `:format` - Specifies the format of the percentage string The number field is %n (defaults to “%n%”).

    # Examples

        iex> Number.as_percentage(100)
        "100.000%"

        iex> Number.as_percentage("98")
        "98.000%"

        iex> Number.as_percentage(100, precision: 0)
        "100%"

        iex> Number.as_percentage(302.24398923423, precision: 5)
        "302.24399%"

        iex> Number.as_percentage(1000, delimiter: '.', separator: ',')
        "1.000,000%"

        iex> Number.as_percentage(100, strip_insignificant_zeros: true)
        "100.0%"

        iex> Number.as_percentage("98a")
        "98a%"

        iex> Number.as_percentage(100, format: "%n  %")
        "100.000  %"

        iex> Number.as_percentage!("98a")
        ** (ArithmeticError) bad argument in arithmetic expression
    """

  @as_percentage [
    valid: [:locale, :precision, :significant, :separator, :delimiter, :strip_insignificant_zeros, :format],
    defaults: [
      locale: :en,
      precision: 3,
      significant: false,
      separator: ".",
      delimiter: "",
      strip_insignificant_zeros: false,
      format: "%n%"
    ]
  ]

  def as_percentage!(number, opts \\ @as_percentage[:defaults])
  def as_percentage!(number, opts) when is_binary(number) do
    case Float.parse(number) do
      {float, ""} -> as_percentage float, opts
      _           -> raise ArithmeticError
    end
  end

  def as_percentage!(number, opts) do
    as_percentage number, opts
  end

  def as_percentage(number, opts \\ @as_percentage[:defaults])
  def as_percentage(number, opts) when is_binary(number) do
    case Float.parse(number) do
      {float, ""} -> as_percentage float, opts
      _           -> format_as_percentage number, opts[:format]
    end
  end

  def as_percentage(number, opts) when is_number(number) do
    Crutches.Option.validate! opts, @as_percentage[:valid]
    opts = Keyword.merge @as_percentage[:defaults], opts

    number/1
    |> Float.to_string([decimals: opts[:precision], compact: opts[:strip_insignificant_zeros]])
    |> as_delimited(delimiter: opts[:delimiter], separator: opts[:separator])
    |> format_as_percentage(opts[:format])
  end

  def format_as_percentage(binary, format) when is_binary(binary) do
    String.replace(format, "%n", String.lstrip(binary, ?-), global: false)
  end
end
