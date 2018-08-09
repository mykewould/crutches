defmodule Crutches.List do
  @moduledoc ~s"""
  Convenience functions for lists.

  This module provides several convenience functions operating on lists.
  Simply call any function (with any options if applicable) to make use of it.
  """

  @doc ~S"""
  Returns the tail of the `collection` from `position`.

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
  @spec from(list(any), integer) :: list(any)
  def from(collection, position) do
    Enum.slice(collection, position, length(collection))
  end

  @doc ~S"""
  Shorten a `list` by a given `amount`.

  When the list is shorter than the amount given, this function returns `nil`.

  ## Examples

      iex> List.shorten(["one", "two", "three"], 2)
      {:ok, ["one"]}

      iex> List.shorten([5, 6], 2)
      {:ok, []}

      iex> List.shorten([5, 6, 7, 8], 5)
      {:error, "Amount to shorten by is greater than the length of the list"}
  """
  @spec shorten(list(any), integer) :: list(any)
  def shorten(list, amount \\ 1) do
    shorten(list, amount, length(list))
  end

  defp shorten(_, amount, len) when len < amount,
    do: {:error, "Amount to shorten by is greater than the length of the list"}

  defp shorten(list, amount, len) do
    shortened_list = Enum.take(list, len - amount)
    {:ok, shortened_list}
  end

  @doc ~S"""
  Returns a copy of the List from the beginning to the required index.

  ## Examples

      iex> List.to(["a", "b", "c"], 0)
      ["a"]

      iex> List.to(["a", "b", "c"], 1)
      ["a", "b"]

      iex> List.to(["a", "b", "c"], 20)
      ["a", "b", "c"]

      iex> List.to(["a", "b", "c"], -1)
      []
  """
  @spec to(list(any), integer) :: list(any)
  def to(collection, position) do
    if position >= 0, do: Enum.take(collection, position + 1), else: []
  end

  @doc ~S"""
  Split a `collection` by an element or by a function (`x`)

  The function removes elements when they are equal to the given element, or;

  When passing in a function, an element gets removed if the function returns
  `true` for that element.

  ## Parameters

  `collection` - The collection to do the split on.
  `x`          - Function predicate or element to split on.

  ## Examples

      iex> List.split(["a", "b", "c", "d", "c", "e"], "c")
      [["a", "b"], ["d"], ["e"]]

      iex> List.split(["c", "a", "b"], "c")
      [[], ["a", "b"]]

      iex> List.split([], 1)
      [[]]

      iex> List.split([1, 2, 3, 4, 5, 6, 7, 8], fn(x) -> rem(x, 2) == 0 end)
      [[1], [3], [5], [7], []]

      iex> List.split(Enum.to_list(1..15), &(rem(&1,3) == 0))
      [[1, 2], [4, 5], [7, 8], [10, 11], [13, 14], []]
  """
  @spec split(list(any), any) :: list(any)
  def split([], _), do: [[]]

  def split(collection, predicate) when not is_function(predicate) do
    split(collection, &(&1 == predicate))
  end

  def split(collection, predicate) do
    {head, tail} =
      List.foldr(collection, {[], []}, fn elem, {head, acc} ->
        case predicate.(elem) do
          true -> {[], [head | acc]}
          false -> {[elem | head], acc}
        end
      end)

    [head] ++ tail
  end

  @doc ~S"""
  Splits or iterates over the array in +number+ of groups, padding any
  remaining slots with +fill_with+ unless it is +false+.

  ## Examples

      iex> List.in_groups(~w(1 2 3 4 5 6 7 8 9 10), 3)
      [["1", "2", "3", "4"], ["5", "6", "7", nil], ["8", "9", "10", nil]]

      iex> List.in_groups(~w(1 2 3 4 5 6 7 8 9 10), 3, false, fn(x) -> Enum.join(x, ",") end)
      ["1,2,3,4", "5,6,7", "8,9,10"]

      iex> List.in_groups(~w(1 2 3 4 5 6 7 8 9 10), 3, false)
      [["1", "2", "3", "4"], ["5", "6", "7"], ["8", "9", "10"]]

  """
  @spec in_groups(list(any), integer, any, (any -> any)) :: list(any)
  def in_groups(collection, number, elem, fun) do
    in_groups(collection, number, elem)
    |> Enum.map(fun)
  end

  @doc ~S"""
  +List.in_groups/3+ accept both an element or a function as +elem+ parameter.
  When the +elem+ is not a function, the +elem+ will be used to fill the empty
  slots in the list. When +elem+ is a function, it will map every *list* created.
  When +elem+ is +false+, it will not fill the list.

  ## Examples

      iex>List.in_groups(~w(1 2 3 4 5 6 7 8), 3, "a")
      [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "a"]]
  """
  def in_groups(collection, number, elem \\ nil)

  def in_groups(collection, number, elem) when is_function(elem) do
    in_groups(collection, number, nil, elem)
  end

  def in_groups(collection, number, elem) do
    coll_size = length(collection)
    group_min = div(coll_size, number)
    group_rem = rem(coll_size, number)

    {result, _} =
      Enum.to_list(1..number)
      |> Enum.reduce({[], collection}, fn x, acc ->
        {list, kollection} = acc

        if x <= group_rem do
          {[Enum.take(kollection, group_min + 1) | list], Enum.drop(kollection, group_min + 1)}
        else
          case group_rem do
            0 ->
              {[Enum.take(kollection, group_min) | list], Enum.drop(kollection, group_min)}

            _ ->
              case elem do
                false ->
                  {[Enum.take(kollection, group_min) | list], Enum.drop(kollection, group_min)}

                _ ->
                  {[Enum.take(kollection, group_min) |> Enum.concat([elem]) | list],
                   Enum.drop(kollection, group_min)}
              end
          end
        end
      end)

    Enum.reverse(result)
  end
end
