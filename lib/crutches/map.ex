defmodule Crutches.Map do
  @doc """
  Travel through a map by specifying a path, JSON-style.
  First parameter is the map, second parameter is the path (either as a list or a string).

  Set the third parameter to `true` if the keys of the map are `Strings`.
  It otherwise defaults to `false`, where it assumes the keys are `atoms`.

  Pass in a string if the keys are strings, otherwise pass an atom (`:"parent.child"`).

  ## Examples

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
    path
    |> String.split(".")
    |> Enum.reduce map, &Map.get(&2, &1)
  end

  def get_path(map, path) when is_map(map) and is_atom(path) do
    path
    |> Atom.to_string
    |> String.split(".")
    |> Enum.reduce map, &Map.get(&2, String.to_atom(&1))
  end

  @doc """
  The fetch version of get_path, where if the key is found returns
  `{:ok, value}`, and if not then `:error`.

  ## Examples

      iex> Map.fetch_path(%{ good: %{ bad: "ugly" } }, :"good.bad")
      {:ok, "ugly"}

      iex> Map.fetch_path(%{ good: "" }, :"good.worse")
      :error
  """
  def fetch_path(map, path) when is_map(map) do
    try do
      {:ok, fetch_path!(map, path)}
    rescue
      _ -> :error
    end
  end

  @doc """
  Throwing version of fetch_path, that returns the value if the path has been
  successfully traversed, and if not then throws an error.

  ## Examples

      iex> Map.fetch_path!(%{ good: %{ bad: "ugly" }}, :"good.ugly")
      ** (KeyError) key :ugly not found in: %{bad: "ugly"}

      iex> Map.fetch_path!(%{ good: %{ bad: "ugly" }}, :"good.bad")
      "ugly"
  """
  def fetch_path!(map, path) when is_map(map) and is_binary(path) do
    path
    |> String.split(".")
    |> Enum.reduce map, &Map.fetch!(&2, &1)
  end

  def fetch_path!(map, path) when is_map(map) and is_atom(path) do
    path
    |> Atom.to_string
    |> String.split(".")
    |> Enum.reduce map, &Map.fetch!(&2, String.to_atom(&1))
  end
end