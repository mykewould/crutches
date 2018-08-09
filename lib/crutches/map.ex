defmodule Crutches.Map do
  require Logger

  @moduledoc ~s"""
  Convenience functions for maps.

  This module provides several convenience functions operating on maps.
  Simply call any function (with any options if applicable) to make use of it.
  """

  @type key :: any
  @type value :: any

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
    key = Map.keys(map) |> List.first()

    value =
      case is_map(map[key]) do
        true -> dkeys_update(map[key], fun)
        _ -> map[key]
      end

    dkeys_update(Map.delete(map, key), fun, Map.put(acc, fun.(key), value))
  end

  @doc ~S"""
  Filters the map, i.e. returns only elements
  for which `fun` returns a truthy value.

  ## Examples

      iex> Map.filter(%{a: 1, b: nil}, fn ({_k, v}) -> !is_nil(v) end)
      %{a: 1}

  """
  @spec filter(map, ({key, value} -> as_boolean(term))) :: map
  def filter(map, fun), do: :maps.filter(fn k, v -> fun.({k, v}) end, map)

  @doc ~S"""
  Filters the map, i.e. returns only elements
  for which `fun` returns a `false` or `nil`.

  ## Examples

      iex> Map.reject(%{a: 1, b: nil}, fn ({_k, v}) -> is_nil(v) end)
      %{a: 1}

  """
  @spec reject(map, ({key, value} -> as_boolean(term))) :: map
  def reject(map, fun), do: :maps.filter(fn k, v -> !fun.({k, v}) end, map)

  @doc """
  Invert a map. Duplicate values raises an error.

  ## Examples

    iex> Map.invert(%{:foo => "bar", "baz" => :qux})
    %{"bar" => :foo, :qux => "baz"}
  """
  @spec invert(map) :: map
  def invert(map) when is_map(map) do
    Enum.reduce(map, %{}, fn {k, v}, acc ->
      if Map.has_key?(acc, v) do
        raise "Cannot invert map with duplicate values"
      else
        Map.put(acc, v, k)
      end
    end)
  end

  @doc """
  Convert map atom keys to strings.

  Top level only - not recursive.

    iex> Map.shallow_stringify_keys(%{foo: "bar", baz: "qux"})
    %{"foo" => "bar", "baz" => "qux"}
    iex> Map.shallow_stringify_keys(%{foo: "bar", baz: %{qux: 1}})
    %{"foo" => "bar", "baz" => %{qux: 1}}
  """
  def shallow_stringify_keys(nil), do: nil

  def shallow_stringify_keys(map) when is_map(map) do
    for {k, v} <- map, do: {Atom.to_string(k), v}, into: %{}
  end
end
