defmodule Todox.Repo.Migrations.CreateTodoItem do
  use Ecto.Migration

  def change do
    create table(:todo_items) do
      add :content, :string
      add :done, :boolean, default: false, null: false

      timestamps()
    end

  end
end
