defmodule Rumbl.SessionController do
  use Rumbl.Web, :controller

  def new conn, _params do
    render conn, "new.html"
  end

  def create conn, %{"session" => %{"username" => username, "password" => password}}  do
    case Rumbl.Auth.login_with_password conn, username, password, repo: Repo do
      {:ok, conn} ->
        conn
        |> redirect(to: page_path(conn, :index))
      {:error, conn} ->
        conn
        |> put_flash(:error, "Nope.")
        |> render("new.html")
    end
  end

  def delete conn, _params do
    conn
    |> Rumbl.Auth.logout
    |> redirect(to: page_path(conn, :index))
  end
end
