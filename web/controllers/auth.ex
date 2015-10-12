defmodule Rumbl.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias Rumbl.Router.Helpers

  def init opts do
    Keyword.fetch! opts, :repo
  end

  def call conn, repo do
    user_id = get_session conn, :user_id
    user = user_id && repo.get Rumbl.User, user_id
    assign conn, :current_user, user
  end

  def login conn, user do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def login_with_password conn, username, password, opts do
    repo = Keyword.fetch! opts, :repo
    user = repo.get_by Rumbl.User, username: username
    if user && Comeonin.Bcrypt.checkpw(password, user.password_hash) do
      {:ok, login(conn, user)}
    else
      {:error, conn}
    end
  end

  def logout conn do
    configure_session conn, drop: true
  end

  def authenticate_user conn, _opts do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "Please log in first")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt
    end
  end
end
