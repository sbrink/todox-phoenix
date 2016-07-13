defmodule Todox.RegistrationController do
  use Todox.Web, :controller
  import Todox.Auth, only: [login: 2]
  alias Todox.User

  def new(conn, _params) do
    changeset = User.registration_changeset(%User{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> login(user)
        |> put_flash(:info, "Registered successfully.")
        |> redirect(to: "/")

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
