defmodule Crutches.Map do
  @doc """
  Travel through a map by specifying a path, JSON-style.
  First parameter is the map, second parameter is the path (either as a list or a string).

  Set the third parameter to `true` if the keys of the map are `Strings`.
  It otherwise defaults to `false`, where it assumes the keys are `atoms`.

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
      iex> Map.get_path(data, "counts.followed_by", true)
      5951762
  """

  def get_path(map, path, string_keys \\ false)

  def get_path(map, path, string_keys) when is_map(map) and is_binary(path) do
    get_path(map, String.split(path, "."), strings)
  end

  def get_path(map, path, true) when is_map(map) and is_list(path) do
    path |> Enum.reduce(map, &Map.get(&2, &1))
  end

  def get_path(map, path, false) when is_map(map) and is_list(path) do
    path |> Enum.map(&String.to_atom/1) |> Enum.reduce(map, &Map.get(&2, &1))
  end
end