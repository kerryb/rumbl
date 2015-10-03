defmodule Rumbl.Repo do
  def all(Rumbl.User) do
    [
      %Rumbl.User{id: 1, name: "Buffy Summers", username: "buffy", password: "slayer"},
      %Rumbl.User{id: 2, name: "Willow Rosenberg", username: "willow", password: "witch"},
      %Rumbl.User{id: 1, name: "Xander Harris", username: "xander", password: "sidekick"},
    ]
  end
  def all(_module), do: []

  def get(module, id) do
    all(module) |> Enum.find(fn map -> map.id == id end)
  end

  def get_by(module, params) do
    all(module) |> Enum.find(fn map ->
      Enum.all?(params, fn {key, value} -> Map.get(map, key) == value end) end)
  end
end
