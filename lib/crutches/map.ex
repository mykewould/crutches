defmodule Crutches.Map do
  require Logger
  @moduledoc ~s"""
  Convenience functions for maps.

  This module provides several convenience functions operating on maps.
  Simply call any function (with any options if applicable) to make use of it.
  """

  @doc ~S"""
  Recursively traverse `map` and change the keys based on `fun`.

  # Examples

      iex> map = %{"hello" => %{"goodbye" => 1}, "akuna" => "matata"}
      iex> Map.dkeys_update(map, fn (key) -> String.to_atom(key) end)
      %{:hello => %{:goodbye => 1}, :akuna => "matata"}

      iex> map = %{"hello" => %{"goodbye" => 1, "akuna" => "matata", "hello" => %{"goodbye" => 1, "akuna" => "matata"}}, "akuna" => "matata"}
      iex> Map.dkeys_update(map, fn (key) -> String.to_atom(key) end)
      %{hello: %{akuna: "matata", goodbye: 1, hello: %{akuna: "matata", goodbye: 1}}, akuna: "matata"}
  """
  def dkeys_update(map, fun), do: dkeys_update(map, fun, %{})
  defp dkeys_update(map, _, acc) when map == %{}, do: acc
  defp dkeys_update(map, fun, acc) do
    key = Map.keys(map) |> List.first
    value = case is_map(map[key]) do
      true -> dkeys_update(map[key], fun)
         _ -> map[key]
    end
    dkeys_update(Map.delete(map, key), fun, Map.put(acc, fun.(key), value))
  end
end
