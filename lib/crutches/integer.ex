defmodule Crutches.Integer do
  @moduledoc ~s"""
  Convenience functions for integers.

  This module provides several convenience functions operating on integers.
  Simply call any function (with any options if applicable) to make use of it.
  """

  @doc ~S"""
  Return the ordinal of `n`. ("st", "nd", "rd", "th")

  # Examples

      iex> Integer.ordinal(-1)
      "st"

      iex> Integer.ordinal(11)
      "th"

      iex> Integer.ordinal(-113)
      "th"

      iex> Integer.ordinal(174)
      "th"

      iex> Integer.ordinal(0)
      "th"

      iex> Integer.ordinal(-23)
      "rd"
  """
  @spec ordinal(integer) :: String.t
  def ordinal(n) when n === 1, do: "st"
  def ordinal(n) when n === 2, do: "nd"
  def ordinal(n) when n === 3, do: "rd"
  def ordinal(n) when is_integer(n) do
    cond do
      n in 0..13 -> "th"
      n in 14..99 -> n |> rem(10) |> abs |> ordinal
      true       -> n |> rem(100) |> abs |> ordinal
    end
  end


  @doc ~S"""
  Return `n` and it's ordinal as a string.

  # Examples

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
  Check whether `n` is evenly divisible by `divisor`.

  # Examples

      iex> Integer.multiple_of?(7, 3)
      false

      iex> Integer.multiple_of?(10, 2)
      true

      iex> Integer.multiple_of?(14, 7)
      true
  """
  @spec multiple_of?(integer, integer) :: boolean
  def multiple_of?(n, divisor), do: rem(n, divisor) == 0

  @doc ~S"""
  Integer.digits copied straight from the Elixir 1.1 standard library, for Elixir < v1.1
  """
  try do
    Integer.digits(58127) == [5, 8, 1, 2, 7]
  rescue
    UndefinedFunctionError ->
      def digits(n, base \\ 10) when is_integer(n)    and n >= 0
                                and  is_integer(base) and base >= 2 do
        do_digits(n, base, [])
      end

      defp do_digits(0, _base, []),  do: [0]
      defp do_digits(0, _base, acc), do: acc
      defp do_digits(n, base, acc)  do
        do_digits div(n, base), base, [rem(n, base) | acc]
      end
  end
end
