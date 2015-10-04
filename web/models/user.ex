defmodule Rumbl.User do
  use Rumbl.Web, :model

  schema "users" do
    field :username, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps
  end
end
