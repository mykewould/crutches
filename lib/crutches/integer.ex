defmodule Crutches.Integer do
  @type s :: String.t()
  @type i :: integer

  @doc ~S"""
  Return _just_ the ordinal of a number ("st", "nd", "rd", "th")

  ## Examples

      iex> Integer.ordinal(-1)
      "st"

      iex> Integer.ordinal(174)
      "th"

      iex> Integer.ordinal(0)
      "th"

      iex> Integer.ordinal(-23)
      "rd"
  """
  @spec ordinal(i) :: s
  def ordinal(n) when is_integer(n) do
    case n |> to_string |> String.slice(-1, 1) do
      "1" -> "st"
      "2" -> "nd"
      "3" -> "rd"
      _ -> "th"
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
  @spec ordinalize(i) :: s
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
  def multiple_of?(n, divisor), do: rem(n, divisor) == 0
end
