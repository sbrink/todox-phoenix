defmodule Todox.SessionController do
  use Todox.Web, :controller
  import Todox.Auth, only: [ login: 4, logout: 1 ]

  def new(conn, _params) do
    render(conn, "new.html", username: "")
  end

  def create(conn, %{"session" => %{"username" => username, "password" => password}}) do
    case Todox.Auth.login(conn, username, password, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Logged in successfully.")
        |> redirect(to: "/")

      {:error, _, _} ->
        conn
        |> put_flash(:error, "Wrong username or password.")
        |> render("new.html", username: username)
    end
  end

  def delete(conn, _params) do
    conn
    |> logout()
    |> put_flash(:info, "Logged out successfully.")
    |> redirect(to: "/")
  end
end
