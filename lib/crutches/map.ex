defmodule Crutches.Map do
  @doc ~S"""
  Recursively traverse a (nested) hash and change the keys based on
  the function provided.
  
  ## Examples
  
  iex> map = %{"hello" => %{"goodbye" => 1}, "akuna" => "matata"}
  iex> Map.dkeys_update(map, fn (key) -> String.to_atom(key) end)
  %{:hello => %{:goodbye => 1}, :akuna => "matata"}
  
  iex> map = %{"hello" => %{"goodbye" => 1, "akuna" => "matata", "hello" => %{"goodbye" => 1, "akuna" => "matata"}}, "akuna" => "matata"}
  iex> Map.dkeys_update(map, fn (key) -> String.to_atom(key) end)
  %{hello: %{akuna: "matata", goodbye: 1, hello: %{akuna: "matata", goodbye: 1}}, akuna: "matata"}
  
  """
  def dkeys_update(map, fun), do: dkeys_update(map, fun, %{})
  def dkeys_update(map, _, acc) when map == %{}, do: acc
  def dkeys_update(map, fun, acc) do
    key = Map.keys(map) |> List.first
    case is_map(map[key]) do
      true -> value = dkeys_update(map[key], fun)
         _ -> value = map[key]
    end
    dkeys_update(Map.delete(map, key), fun, Map.put(acc, fun.(key), value))
  end
end
