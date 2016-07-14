defmodule Todox.TodoItem do
  use Todox.Web, :model

  schema "todo_items" do
    field :content, :string
    field :done, :boolean, default: false

    belongs_to :user, Todox.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content, :done])
    |> validate_required([:content, :done])
    |> validate_length(:content, min: 5)
  end
end
