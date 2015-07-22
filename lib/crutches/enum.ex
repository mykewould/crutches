defmodule Crutches.Enum do
  @type b :: Boolean
  @type a :: Any
  @type l :: List
  @type m :: Map

  @doc ~S"""
  Returns a copy of the Enum without the specified elements.

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
  @spec without(l, l) :: l
  def without(collection, elements) when is_list(collection) do
    if Keyword.keyword? collection do
      Keyword.drop collection, elements
    else
      Enum.reject collection, &Enum.member?(elements, &1)
    end
  end

  @spec without(m, l) :: m
  def without(collection, elements) when is_map(collection) do
    Map.drop collection, elements
  end

  @doc ~S"""
  Shorthand for length(collection) > 1

  ## Examples

      iex> Enum.many?([1, 2, 3])
      true

      iex> Enum.many?(%{ name: "Kash" })
      false

      iex> Enum.many?([ answer: 42 ])
      false
  """
  @spec many?(l) :: b
  def many?(collection) when is_list(collection), do: length(collection) > 1

  @spec many?(m) :: b
  def many?(collection) when is_map(collection), do: Map.size(collection) > 1
end