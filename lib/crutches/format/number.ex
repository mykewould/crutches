defmodule Crutches.Format.Number do
  alias Crutches.Option

  @moduledoc ~s"""
  Formatting helper functions for numbers.

  This module contains various helper functions that should be of use to you
  when writing user interfaces or other parts of your application that have
  to deal with number formatting.

  Simply call the desired function with any relevant options that you may need.
  """

  @doc ~s"""
  Formats `number` with grouped thousands.

  # Options

  Pass these via the `opts` keyword list.

  - `:delimiter` (string) --- Delmiter to use for delimiting the thousands.
  *Default:* `","`
  - `:separator` (string) --- Separator to use for separating the integer part
  from the decimal part. *Default:* `"."`

  # Examples

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

  def as_delimited(number, opts \\ [])
  def as_delimited(number, opts) when is_binary(number) do
    opts = Option.combine!(opts, @as_delimited)

    if String.contains?(number, ".") do
      [number, decimal] = String.split(number, ".")
      format_number(number, opts) <> opts[:separator] <> decimal
    else
      format_number(number, opts)
    end
  end

  def as_delimited(number, opts) do
    number
    |> to_string
    |> as_delimited(opts)
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

  @doc ~S"""
  Formats a `number` with the specified level of :precision (e.g., 112.32 has a
  precision of 2 if `:significant` is false, and 5 if `:significant` is true). You
  can customize the format in the `options` Dict.

  # Options

    * `:locale` - Sets the locale to be used for formatting (defaults to current locale).
    * `:precision` - Sets the precision of the number (defaults to 3).
    * `:significant` - If true, precision will be the # of significant_digits. If false, the # of fractional digits (defaults to false).
    * `:separator` - Sets the separator between the fractional and integer digits (defaults to “.”).
    * `:delimiter` - Sets the thousands delimiter (defaults to “”).
    * `:strip_insignificant_zeros` - If true removes insignificant zeros after the decimal separator (defaults to false).

  # Examples

      iex> Number.as_rounded(111.2345)
      "111.235"

      iex> Number.as_rounded(111.2345, precision: 2)
      "111.23"

      iex> Number.as_rounded(13, precision: 5)
      "13.00000"

      iex> Number.as_rounded(389.32314, precision: 0)
      "389"

      iex> Number.as_rounded(111.2345, significant: true)
      "111"

      iex> Number.as_rounded(111.2345, precision: 1, significant: true)
      "100"

      iex> Number.as_rounded(13, precision: 5, significant: true)
      "13.000"

      # iex> Number.as_rounded(111.234, locale: :fr)
      # "111,234"

      iex> Number.as_rounded(13, precision: 5, significant: true, strip_insignificant_zeros: true)
      "13"

      iex> Number.as_rounded(389.32314, precision: 4, significant: true)
      "389.3"

      iex> Number.as_rounded(1111.2345, precision: 2, separator: ",", delimiter: ".")
      "1.111,23"

  """
  @as_rounded [
    valid: ~w(precision significant separator delimiter strip_insignificant_zeros)a,
    defaults: [
      precision: 3,
      significant: false,
      separator: ".",
      delimiter: "",
      strip_insignificant_zeros: false
    ]
  ]

  def as_rounded(number, opts \\ @as_rounded[:defaults])
  def as_rounded(number, opts) when is_binary(number) do
    number |> String.to_float |> as_rounded(opts)
  end

  def as_rounded(number, opts) when is_integer(number) do
    number |> :erlang.float |> as_rounded(opts)
  end
  def as_rounded(number, opts) when is_float(number) do
    opts = Option.combine!(opts, @as_rounded)

    number
    |> prepare_as_rounded(opts[:precision], opts[:significant])
    |> strip_trailing_zeros(opts[:strip_insignificant_zeros] || opts[:precision] == 0)
    |> as_delimited(Keyword.take(opts, @as_delimited[:valid]))
  end

  defp prepare_as_rounded(number, precision, true) do
    number |> make_significant(precision)
  end
  defp prepare_as_rounded(number, precision, false) do
    number = Float.round(number, precision)
    if precision > 0 do
      :io_lib.format("~.#{precision}f", [number]) |> List.to_string
    else
      number |> trunc |> Integer.to_string
    end
  end

  @doc ~s"""
  Formats a `number` as a US phone number.

  # Options

  Pass these via the `opts` keyword list.

  - `:area_code` (boolean) --- Whether the number has an area code. *Default:*
  `false`
  - `:delimiter` (string) --- Delimiter to use. *Default:* `"-"`
  - `:extension` (number) --- Extension to add to the number. *Default:* `nil`
  - `:country_code` (number) --- Country code to add. *Default:* `nil`

  # Examples

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
    valid: [:area_code, :delimiter, :extension, :country_code],
    defaults: [
      area_code: false,
      delimiter: "-",
      extension: nil,
      country_code: nil
    ]
  ]

  def as_phone(number, opts \\ [])
  def as_phone(number, opts) when is_list(number) do
    number
    |> to_string
    |> as_phone(opts)
  end

  def as_phone(number, opts) when is_binary(number) do
    case Integer.parse(number) do
      {integer, ""} -> as_phone(integer, opts)
                  _ -> number
    end
  end

  def as_phone(number, opts) when is_integer(number) do
    opts = Option.combine!(opts, @as_phone)
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
    safe_string
    |> String.split_at(3)
    |> Tuple.to_list
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
    phone_components
    |> Enum.join(delimiter)
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
  Formats `number` as a currency string.

  # Options

  You can customize the format with the `opts` keyword list.

  - `:locale` (atom) --- Locale to be used for formatting. **Not implemented.**
  - `:precision` (integer) --- Level of precision. *Default:* `2`
  - `:unit` (string) --- Denomination of the currency. *Default:* `"$"`
  - `:separator` (string) --- Separator between the integer and decimal part.
  *Default:* `"."`
  - `:delimiter` (string) --- Thousands delimiter. *Default:* `","`
  - `:format` (string) --- Format for non-negative numbers. `%u` is the currency unit, `%n`
  is the number. *Default:* `"%u%n"`
  - `:negative_format` (string) --- Format for negative numbers. `%n` is the
  absolute value of the number. *Default:* `"-%u%n"`

  # Examples

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
    valid: [:locale, :precision, :unit, :separator, :delimiter, :format, :negative_format],
    defaults: [
      locale: :en,
      precision: 2,
      unit: "$",
      separator: ".",
      delimiter: ",",
      format: "%u%n",
      negative_format: "-%u%n"
    ]
  ]

  def as_currency(number, opts \\ [])
  def as_currency(number, opts) when is_binary(number) do
    case Float.parse(number) do
      {float, ""} ->
        as_currency(float, opts)
      _ ->
        opts = Option.combine!(opts, @as_currency)
        format_as_currency(number, opts[:unit], opts[:format])
    end
  end

  def as_currency(number, opts) when is_number(number) do
    opts = Option.combine!(opts, @as_currency)
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

  @doc ~s"""
  Throwing version of `as_currency`.

  Raises an `ArithmeticError` when you pass in anything other than a number.
  """

  def as_currency!(number, opts \\ [])
  def as_currency!(number, opts) when is_binary(number) do
    case Float.parse(number) do
      {float, ""} -> as_currency(float, opts)
                _ -> raise ArithmeticError
    end
  end

  def as_currency!(number, opts) do
    as_currency number, opts
  end

  @doc ~s"""
  Formats `number` as a percentage string.

  # Options

  Pass these via the `opts` keyword list.

  - `:locale` (atom) --- Locale to be used for formatting. *Not implemented.*
  - `:precision` (integer) --- Precision of the number. *Default:* `3`
  - `:significant` (boolean) --- Format significant digits? Otherwise fractional
  digits are used. *Default:* `false`
  - `:separator` (string) --- Separator between the fractional and integer
  digits. *Default:* `"."`
  - `:delimiter` (string) --- Thousands delimiter. *Default:* `""`
  - `:strip_insignificant_zeros` (boolean) --- Remove insignificant zeros after
  the decimal separator? *Default:* `false`
  - `:format` (string) --- Format of the percentage string. `%n` is the number
  field. *Default:* `"%n%"`

  # Examples

      iex> Number.as_percentage(100)
      "100.000%"

      iex> Number.as_percentage("98")
      "98.000%"

      iex> Number.as_percentage(100, precision: 0)
      "100%"

      iex> Number.as_percentage(302.24398923423, precision: 5)
      "302.24399%"

      iex> Number.as_percentage(1000, delimiter: ".", separator: ",")
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
    valid: [:locale, :precision, :significant, :separator, :delimiter,
      :strip_insignificant_zeros, :format],
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

  def as_percentage(number, opts \\ [])
  def as_percentage(number, opts) when is_binary(number) do
    case Float.parse(number) do
      {float, ""} ->
        as_percentage(float, opts)
      _ ->
        opts = Option.combine!(opts, @as_percentage)
        format_as_percentage(number, opts[:format])
    end
  end

  def as_percentage(number, opts) when is_number(number) do
    opts = Option.combine!(opts, @as_percentage)

    number/1
    |> Float.to_string([decimals: opts[:precision], compact: opts[:strip_insignificant_zeros]])
    |> as_delimited(delimiter: opts[:delimiter], separator: opts[:separator])
    |> format_as_percentage(opts[:format])
  end

  defp format_as_percentage(binary, format) when is_binary(binary) do
    String.replace(format, "%n", String.lstrip(binary, ?-), global: false)
  end

  @doc ~s"""
  Throwing version of `as_percentage`.
  """
  def as_percentage!(number, opts \\ [])
  def as_percentage!(number, opts) when is_binary(number) do
    case Float.parse(number) do
      {float, ""} -> as_percentage(float, opts)
                _ -> raise ArithmeticError
    end
  end

  def as_percentage!(number, opts) do
    as_percentage(number, opts)
  end

  @doc ~S"""
  Formats and approximates `number` for human readability.

  `1200000000` becomes `"1.2 Billion"`. This is useful as larger numbers become
  harder to read.

  See `as_human_size` if you want to print a file size.

  You can also define you own unit-quantifier names if you want to use other
  decimal units (eg.: 1500 becomes "1.5 kilometers", 0.150 becomes
  “150 milliliters”, etc). You may define a wide range of unit quantifiers, even
  fractional ones (centi, deci, mili, etc).

  # Options

  - `:locale` (atom) --- Locale to be used for formatting. *Default:*
  current locale.
  - `:precision` (integer) --- Precision of the number. *Default:* `3`
  - `:significant` - If true, precision will be the # of significant_digits. If
  false, the # of fractional digits (defaults to true)
  - `:separator` (string) --- Separator between the fractional and integer
  digits. *Default:* `"."`
  - `:delimiter` (string) --- Thousands delimiter. *Default:* `""`
  - `:strip_insignificant_zeros` (boolean) --- Remove insignificant zeros after
  the decimal separator? *Default:* `true`
  -`:units` (keyword list/string) --- Keyword list of unit quantifier names,
  *or* a string containing an i18n scope pointing to it.
  - `:format` (string) --- Format of the output string. `%u` is the quantifier,
  `%n` is the number. *Default:* `"%n %u"`

  # i18n

  This function takes a keyword list of quantifier names to use for formatting.
  It supports the following keys:

  - `:unit`
  - `:ten`
  - `:hundred`
  - `:thousand`
  - `:million`
  - `:billion`
  - `:trillion`
  - `:quadrillion`
  - `:deci`
  - `:centi`
  - `:milli`
  - `:micro`
  - `:nano`
  - `:pico`
  - `:femto`

  # Examples

      iex> Number.as_human(123)
      "123"

      iex> Number.as_human(1234)
      "1.23 Thousand"

      iex> Number.as_human(12345)
      "12.3 Thousand"

      iex> Number.as_human(1234567)
      "1.23 Million"

      iex> Number.as_human(1234567890)
      "1.23 Billion"

      iex> Number.as_human(1234567890123)
      "1.23 Trillion"

      iex> Number.as_human(1234567890123456)
      "1.23 Quadrillion"

      iex> Number.as_human(1234567890123456789)
      "1230 Quadrillion"

      iex> Number.as_human(489939, precision: 2)
      "490 Thousand"

      iex> Number.as_human(489939, precision: 4)
      "489.9 Thousand"

      iex> Number.as_human(1234567, precision: 4, significant: false)
      "1.2346 Million"

      iex> Number.as_human(1234567, precision: 1, separator: ",", significant: false)
      "1,2 Million"

      iex> Number.as_human(500000000, precision: 5)
      "500 Million"

      iex> Number.as_human(12345012345, significant: false)
      "12.345 Billion"

      iex> Number.as_human!("abc")
      ** (ArithmeticError) bad argument in arithmetic expression
  """
  @as_human [
    valid: [:locale, :precision, :significant, :separator, :delimiter,
      :strip_insignificant_zeros, :units, :format],
    defaults: [
      precision: 3,
      significant: true,
      separator: ".",
      delimiter: "",
      strip_insignificant_zeros: true,
      units: [
        quadrillion: "Quadrillion",
        trillion: "Trillion",
        billion: "Billion",
        million: "Million",
        thousand: "Thousand",
        hundred: "",
        ten: "",
        unit: "",
        deci: "deci",
        centi: "centi",
        milli: "milli",
        micro: "micro",
        nano: "nano",
        pico: "pico",
        femto: "femto"
      ],
      format: "%n %u"
    ]
  ]

  def as_human(number, opts \\ [])
  def as_human(number, opts) when is_number(number) do
    opts = Option.combine!(opts, @as_human)
    {exp, unit, sign} = closest_size_and_sign(number)

    precision = opts[:precision]

    if precision < 0 do
      precision = 0
    end

    delimited_opts = Keyword.take(opts, @as_delimited[:valid])

    fract_num =
      abs(number) / :math.pow(10, exp)
      |> rounded_or_significant(opts[:significant], precision)
      |> strip_trailing_zeros(opts[:strip_insignificant_zeros])
      |> as_delimited(delimited_opts)

    if sign < 0 do
      fract_num = "-" <> fract_num
    end

    format_as_human(fract_num, opts[:units][unit], opts[:format])
  end

  defp closest_size_and_sign(number) when is_number(number) do
    tenth_exp =
      number
      |> abs
      |> :math.log10
      |> trunc

    sign = number_sign(number)

    cond do
      tenth_exp >= 15 -> {15, :quadrillion, sign}
      tenth_exp >= 12 -> {12, :trillion, sign}
      tenth_exp >= 9  -> {9, :billion, sign}
      tenth_exp >= 6  -> {6, :million, sign}
      tenth_exp >= 3  -> {3, :thousand, sign}
      tenth_exp >= 2  -> {0, :hundred, sign}
      tenth_exp >= 1  -> {0, :ten, sign}
      tenth_exp >= 0  -> {0, :unit, sign}
      tenth_exp < 0  && tenth_exp >= -1  -> {-1, :deci, sign}
      tenth_exp < -1 && tenth_exp >= -2  -> {-2, :centi, sign}
      tenth_exp < -2 && tenth_exp >= -3  -> {-3, :milli, sign}
      tenth_exp < -3 && tenth_exp >= -6  -> {-6, :micro, sign}
      tenth_exp < -6 && tenth_exp >= -9  -> {-9, :nano, sign}
      tenth_exp < -9 && tenth_exp >= -12 -> {-12, :pico, sign}
      tenth_exp < -12 -> {-15, :femto, sign}
    end
  end

  defp number_sign(number) when is_number(number) do
    cond do
      number >= 0 ->  1
      true -> -1
    end
  end

  defp rounded_or_significant(number, significant, precision) do
    case significant do
      true ->
        make_significant(number, precision)
      false ->
        number = Float.round(number, precision)

        if precision > 0 do
          :io_lib.format("~.#{precision}f", [number]) |> List.to_string
        else
          number |> trunc |> Integer.to_string
        end
    end
  end

  defp make_significant(number, precision) do
    digits = (:math.log10(number) + 1) |> Float.floor |> trunc
    multiplier = :math.pow(10, digits - precision)
    extra_precision = precision - digits

    result = Float.round(number / multiplier) * multiplier

    if extra_precision > 0 do
      :io_lib.format("~.#{extra_precision}f", [result]) |> List.to_string
    else
      result |> trunc |> Integer.to_string
    end
  end

  defp strip_trailing_zeros(number, strip) do
    if strip do
      strip_trailing_zeros(number)
    else
      number
    end
  end

  defp strip_trailing_zeros(number) do
    if String.contains?(number, ".") do
      case String.reverse(number) do
        "0" <> number -> String.reverse(number) |> strip_trailing_zeros
        "." <> number -> String.reverse(number)
        number -> String.reverse(number)
      end
    else
      number
    end
  end

  defp format_as_human(binary, unit, format) when is_binary(binary) do
    str = String.replace(format, "%n", binary, global: false)
    String.replace(str, "%u", unit, global: false) |> String.strip
  end

  @doc ~S"""
  Throwing version of `as_human`, raises if the input is not a valid number.
  """
  def as_human!(number, opts \\ [])
  def as_human!(number, opts) when is_binary(number) do
    case Float.parse(number) do
      {num, ""} -> as_human(num, opts)
              _ -> raise(ArithmeticError, message: "bad argument in arithmetic expression")
    end
  end

  def as_human!(number, opts) when is_number(number) do
    as_human(number, opts)
  end
end
