defmodule Crutches.Integer do
  @doc ~S"""
  Return _just_ the ordinal of a number ("st", "nd", "rd", "th")

  ## Examples

      iex> Integer.ordinal(-1)
      "st"

      iex> Integer.ordinal(11)
      "th"

      iex> Integer.ordinal(174)
      "th"

      iex> Integer.ordinal(0)
      "th"

      iex> Integer.ordinal(-23)
      "rd"
  """
  @spec ordinal(integer) :: String.t
  def ordinal(n) when is_integer(n) do
    cond do
      n >= 11 and n <= 13 ->
        "th"
      true ->
        case :erlang.abs(:erlang.rem(n, 10)) do
          1 -> "st"
          2 -> "nd"
          3 -> "rd"
          _ -> "th"
        end
    end
  end

  @doc ~S"""
  Return the number and it's ordinal as a string

  ## Examples

      iex> Integer.ordinalize(2)
      "2nd"

      iex> Integer.ordinalize(276)
      "276th"

      iex> Integer.ordinalize(-8)
      "-8th"
  """
  @spec ordinalize(integer) :: String.t
  def ordinalize(n) when is_integer(n), do: to_string(n) <> ordinal(n)

  @doc ~S"""
  Check whether the integer is evenly divisible by the argument.

  ## Examples

      iex> Integer.multiple_of?(7, 3)
      false

      iex> Integer.multiple_of?(10, 2)
      true

      iex> Integer.multiple_of?(14, 7)
      true
  """
  @spec multiple_of?(integer, integer) :: boolean
  def multiple_of?(n, divisor), do: rem(n, divisor) == 0
end
