defmodule Crutches.Enum do
  @moduledoc ~s"""
  Convenience functions for enums.

  This module provides several convenience functions operating on enums.
  Simply call any function (with any options if applicable) to make use of it.
  """

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
end
