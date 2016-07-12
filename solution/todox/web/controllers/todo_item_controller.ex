defmodule Todox.TodoItemController do
  use Todox.Web, :controller
  alias Todox.TodoItem

  def index(conn, _params) do
    todo_items_query = from todo_item in TodoItem, order_by: [desc: todo_item.id]
    todo_items = Repo.all(todo_items_query)

    render(conn, "index.html", todo_items: todo_items)
  end

  def new(conn, _params) do
    changeset = TodoItem.changeset(%TodoItem{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"todo_item" => todo_item_params}) do
    changeset = TodoItem.changeset(%TodoItem{}, todo_item_params)

    case Repo.insert(changeset) do
      {:ok, _todo_item} ->
        conn
        |> put_flash(:info, "Todo item created successfully.")
        |> redirect(to: todo_item_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    todo_item = Repo.get!(TodoItem, id)
    changeset = TodoItem.changeset(todo_item)

    render(conn, "edit.html", todo_item: todo_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo_item" => todo_item_params}) do
    todo_item = Repo.get!(TodoItem, id)
    changeset = TodoItem.changeset(todo_item, todo_item_params)

    case Repo.update(changeset) do
      {:ok, todo_item} ->
        conn
        |> put_flash(:info, "Todo item updated successfully.")
        |> redirect(to: todo_item_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", todo_item: todo_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo_item = Repo.get!(TodoItem, id)

    Repo.delete!(todo_item)

    conn
    |> put_flash(:info, "Todo item deleted successfully.")
    |> redirect(to: todo_item_path(conn, :index))
  end
end
