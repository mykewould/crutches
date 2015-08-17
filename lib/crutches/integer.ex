defmodule Crutches.Integer do
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
  def multiple_of?(n, divisor) when is_integer(n), do: rem(n, divisor) == 0
end
