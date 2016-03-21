defmodule Crutches.Map do
  require Logger
  @moduledoc ~s"""
  Convenience functions for maps.

  This module provides several convenience functions operating on maps.
  Simply call any function (with any options if applicable) to make use of it.
  """

  @doc """
  ## WARNING: Will be removed in 2.0. Please use Kernel.get_in/2 and Kernel.put_in/3 instead.

  Travel through `map` according to a specified `path`.

  The `path` is either a list or a string.  Pass in a string if the keys in
  `map` are strings, otherwise pass an atom (`:"parent.child"`).

  # Examples

      iex> data = %{
      ...>   "bio" => "Get BUSH now!",
      ...>   "counts" => %{"followed_by" => 5951762, "follows" => 1623, "media" => 18112},
      ...>   "full_name" => "snoopdogg",
      ...>   "id" => "1574083",
      ...>   "profile_picture" => "https://igcdn-photos-a-a.akamaihd.net/hphotos-ak-xap1/t51.2885-19/11186934_976841435684008_1692889037_a.jpg",
      ...>   "username" => "snoopdogg",
      ...>   "website" => "http://smarturl.it/BushAlbum"
      ...> }
      iex> Map.get_path(data, "counts.followed_by")
      5951762

      iex> Map.get_path(%{ answer: 42 }, :answer)
      42
  """

  def get_path(map, path) when is_map(map) and is_binary(path) do
    Logger.warn "Crutches: Map.get_path/2 is deprecated. Please use Elixir's Kernel.get_in/2."
    path
    |> String.split(".")
    |> Enum.reduce(map, &Map.get(&2, &1))
  end

  def get_path(map, path) when is_map(map) and is_atom(path) do
    Logger.warn "Crutches: Map.get_path/2 is deprecated. Please use Elixir's Kernel.get_in/2."
    path
    |> Atom.to_string
    |> String.split(".")
    |> Enum.reduce(map, &Map.get(&2, String.to_atom(&1)))
  end

  @doc """
  ## WARNING: Will be removed in 2.0. Please use Kernel.get_in/2 and Kernel.put_in/3 instead.

  The fetch version of get_path, where if the key is found returns
  `{:ok, value}`, and if not then `:error`.

  # Examples

      iex> Map.fetch_path(%{ good: %{ bad: "ugly" } }, :"good.bad")
      {:ok, "ugly"}

      iex> Map.fetch_path(%{ good: "" }, :"good.worse")
      :error
  """
  def fetch_path(map, path) when is_map(map) do
    Logger.warn "Crutches: Map.fetch_path/2 is deprecated. Please use Elixir's Kernel.get_in/2."
    try do
      {:ok, fetch_path!(map, path)}
    rescue
      _ -> :error
    end
  end

  @doc """
  ## WARNING: Will be removed in 2.0. Please use Kernel.get_in/2 and Kernel.put_in/3 instead.

  Throwing version of fetch_path, that returns the value if the path has been
  successfully traversed, and if not then throws an error.

  # Examples

      iex> Map.fetch_path!(%{ good: %{ bad: "ugly" }}, :"good.ugly")
      ** (KeyError) key :ugly not found in: %{bad: "ugly"}

      iex> Map.fetch_path!(%{ good: %{ bad: "ugly" }}, :"good.bad")
      "ugly"
  """
  def fetch_path!(map, path) when is_map(map) and is_binary(path) do
    Logger.warn "Crutches: Map.fetch_path/2 is deprecated. Please use Elixir's Kernel.get_in/2."
    path
    |> String.split(".")
    |> Enum.reduce(map, &Map.fetch!(&2, &1))
  end

  def fetch_path!(map, path) when is_map(map) and is_atom(path) do
    Logger.warn "Crutches: Map.fetch_path/2 is deprecated. Please use Elixir's Kernel.get_in/2."
    path
    |> Atom.to_string
    |> String.split(".")
    |> Enum.reduce(map, &Map.fetch!(&2, String.to_atom(&1)))
  end

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
