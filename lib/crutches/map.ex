defmodule Crutches.Map do
  @doc ~S"""
  Recursively traverse a (nested) hash and change the keys based on
  the function provided.

  ## Examples

  iex> map = %{"hello" => %{"goodbye" => 1}, "akuna" => "matata"}
  iex> Map.deep_key_change(map, fn (key) -> String.to_atom(key) end)
  %{:hello => %{:goodbye => 1}, :akuna => "matata"}

  iex> map = %{"hello" => %{"goodbye" => 1, "akuna" => "matata", "hello" => %{"goodbye" => 1, "akuna" => "matata"}}, "akuna" => "matata"}
  iex> Map.deep_key_change(map, fn (key) -> String.to_atom(key) end)
  %{hello: %{akuna: "matata", goodbye: 1, hello: %{akuna: "matata", goodbye: 1}}, akuna: "matata"}

  """
  def deep_key_change(map, fun) do
    deep_key_change(map, fun, %{})
  end

  def deep_key_change(map, _, acc) when map == %{} do
    acc
  end

  def deep_key_change(map, fun, acc) do
    key = Map.keys(map) |> List.first
    if is_map(map[key]) do
      value = deep_key_change(map[key], fun, %{})
    else
      value = map[key]
    end
    acc = Map.put(acc, fun.(key), value)
    map = Map.delete(map, key)
    deep_key_change(map, fun, acc)
  end
end
