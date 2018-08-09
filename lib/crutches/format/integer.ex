defmodule Crutches.Format.Integer do
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
  @spec ordinal(integer) :: String.t()
  def ordinal(n) when is_integer(n) do
    cond do
      n == 1 -> "st"
      n == 2 -> "nd"
      n == 3 -> "rd"
      n in 0..13 -> "th"
      n in 14..99 -> n |> rem(10) |> abs |> ordinal
      true -> n |> rem(100) |> abs |> ordinal
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
  @spec ordinalize(integer) :: String.t()
  def ordinalize(n) when is_integer(n), do: Integer.to_string(n) <> ordinal(n)
end
