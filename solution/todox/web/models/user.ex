defmodule Todox.User do
  use Todox.Web, :model
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]
  alias Ecto.Changeset

  schema "users" do
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username])
    |> validate_required([:username])
    |> validate_length(:username, min: 3, max: 20)
    |> unique_constraint(:username)
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> changeset(params)
    |> cast(params, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 100)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
