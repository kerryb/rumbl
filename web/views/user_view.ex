defmodule Rumbl.UserView do
  use Rumbl.Web, :view
  alias Rumbl.User

  def render "user.json", %{user: user} do
    %{id: user.id, username: user.username}
  end
end
