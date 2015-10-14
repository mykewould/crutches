defmodule Crutches.Enum do
  @moduledoc ~s"""
  Convenience functions for enums.

  This module provides several convenience functions operating on enums.
  Simply call any function (with any options if applicable) to make use of it.
  """

  @type t :: Enumerable.t
  @type element :: any

  @doc ~S"""
  Returns a copy of the `collection` without the specified `elements`.

  ## Examples

      iex> Enum.without(["David", "Rafael", "Aaron", "Todd"], ["Aaron", "Todd"])
      ["David", "Rafael"]

      iex> Enum.without([1, 1, 2, 1, 4], [1, 2])
      [4]

      iex> Enum.without(%{ movie: "Inception", release: 2010 }, [:release])
      %{ movie: "Inception" }

      iex > Enum.without([ answer: 42 ], [:answer])
      []
  """
  @spec without(list(any), list(any)) :: list(any)
  def without(collection, elements) when is_list(collection) do
    if Keyword.keyword? collection do
      Keyword.drop collection, elements
    else
      Enum.reject collection, &Enum.member?(elements, &1)
    end
  end

  @spec without(map, list(any)) :: map
  defdelegate without(map, keys), to: Map, as: :drop

  @doc ~S"""
  Shorthand for length(collection) > 1

  ## Examples

      iex> Enum.many?([])
      false

      iex> Enum.many?([nil, nil, nil])
      true

      iex> Enum.many?([1, 2, 3])
      true

      iex> Enum.many?(%{})
      false

      iex> Enum.many?(%{ name: "Kash" })
      false

      iex> Enum.many?([ answer: 42 ])
      false
  """
  @spec many?(list(any)) :: boolean
  def many?([]), do: false
  def many?([_ | tail]), do: !Enum.empty?(tail)

  @spec many?(map) :: boolean
  def many?(%{}), do: false
  def many?(collection) when is_map(collection), do: map_size(collection) > 1

  @doc """
  Invokes the given `fun` for each item in the enumerable and returns `true` if
  none of the invocations return a truthy value.
  Returns `false` otherwise.

  ## Examples

      iex> Enum.none?([2, 4, 6], fn(x) -> rem(x, 2) == 1 end)
      true

      iex> Enum.none?([2, 3, 4], fn(x) -> rem(x, 2) == 1 end)
      false

  If no function is given, it defaults to checking if all items in the
  enumerable are a falsy value.

      iex> Enum.none?([false, false, false])
      true

      iex> Enum.none?([false, true, false])
      false
  """
  @spec none?(t) :: boolean
  @spec none?(t, (element -> as_boolean(term))) :: boolean

  def none?(enumerable, fun \\ fn(x) -> x end)

  def none?(enumerable, fun) do
    not Enum.any?(enumerable, fun)
  end

  @doc """
  Invokes the given `fun` for each item in the enumerable and returns `true` if
  exactly one invocation returns a truthy value.
  Returns `false` otherwise.

  ## Examples

      iex> Enum.one?([1, 2, 3], fn(x) -> rem(x, 2) == 0 end)
      true

      iex> Enum.one?([1, 3, 5], fn(x) -> rem(x, 2) == 0 end)
      false

      iex> Enum.one?([2, 4, 6], fn(x) -> rem(x, 2) == 0 end)
      false

  If no function is given, it defaults to checking if exactly one item in the
  enumerable is a truthy value.

      iex> Enum.one?([1, 2, 3])
      false

      iex> Enum.one?([1, nil, false])
      true
  """
  @spec one?(t) :: boolean
  @spec one?(t, (element -> as_boolean(term))) :: boolean
  def one?(enumerable, fun \\ fn(x) -> x end) do
    match? [_], Stream.filter(enumerable, fun) |> Enum.take(2)
  end
end
