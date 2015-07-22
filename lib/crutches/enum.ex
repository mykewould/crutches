defmodule Crutches.Enum do
  @type b :: Boolean
  @type a :: Any
  @type l :: List
  @type m :: Map

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
  def many?(collection) when is_list(collection) do
    case Enum.at(collection, 1) do
      nil -> false
      _ -> true
    end
  end

  @spec many?(m) :: b
  def many?(collection) when is_map(collection), do: Map.size(collection) > 1
end