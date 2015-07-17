defmodule Crutches.List do
  @type t :: List
  @type i :: Integer

  @doc ~S"""
  Returns a copy of the List without the specified elements.

  ## Examples

      iex> List.without(["David", "Rafael"], ["David"])
      ["Rafael"]

      iex> List.without(["David", "Rafael", "Aaron", "Todd"], ["Aaron", "Todd"])
      ["David", "Rafael"]

      iex> List.without([1, 1, 2, 1, 4], [1, 2])
      [4]
  """
  @spec without(t, t) :: t
  def without(collection, elements) do
    Enum.filter(collection, fn(x) -> !Enum.member?(elements, x) end)
  end

  @doc ~S"""
  Returns the tail of the array from +position+.

  ## Examples


      iex> List.from(["a", "b", "c", "d"], 0)
      ["a", "b", "c", "d"]

      iex> List.from(["a", "b", "c", "d"], 2)
      ["c", "d"]

      iex> List.from(["a", "b", "c", "d"], 10)
      []

      iex> List.from([], 0)
      []

      iex> List.from(["a", "b", "c", "d"], -2)
      ["c", "d"]

      iex> List.from(["a", "b", "c", "d"], -10)
      []

  """
  @spec from(t, i) :: t
  def from(collection, position) do
    Enum.slice(collection, position, Enum.count(collection))
  end

end
