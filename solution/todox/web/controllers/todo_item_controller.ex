defmodule Todox.TodoItemController do
  use Todox.Web, :controller
  alias Todox.TodoItem

  plug :only_logged_in when action in [:new, :create, :edit, :update, :delete]
  plug :only_author when action in [:update, :delete]

  def index(conn, _params) do
    todo_items_query = from todo_item in TodoItem,
      order_by: [desc: todo_item.id],
      preload: [:user]
    todo_items = Repo.all(todo_items_query)

    render(conn, "index.html", todo_items: todo_items)
  end

  def new(conn, _params) do
    changeset = TodoItem.changeset(%TodoItem{ user: conn.assigns.current_user })

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"todo_item" => todo_item_params}) do
    changeset = TodoItem.changeset(%TodoItem{ user: conn.assigns.current_user }, todo_item_params)

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
      {:ok, _todo_item} ->
        conn
        |> put_flash(:info, "Todo item updated successfully.")
        |> redirect(to: todo_item_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", todo_item: todo_item, changeset: changeset)
    end
  end

  def toggle(conn, %{"id" => id, "done" => done}) do
    todo_item = Repo.get!(TodoItem, id)
    changeset = TodoItem.changeset(todo_item, %{ done: done })

    Repo.update!(changeset)

    render(conn, %{ done: done })
  end

  def delete(conn, %{"id" => id}) do
    todo_item = Repo.get!(TodoItem, id)

    Repo.delete!(todo_item)

    conn
    |> put_flash(:info, "Todo item deleted successfully.")
    |> redirect(to: todo_item_path(conn, :index))
  end

  defp only_logged_in(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access this page")
      |> redirect(to: "/")
    end
  end

  defp only_author(conn, _) do
    case Repo.get_by(TodoItem, id: conn.params["id"], user_id: conn.assigns.current_user.id) do
      %TodoItem{} ->
        conn

      _ ->
        conn
        |> put_flash(:error, "Only item author can do this.")
        |> redirect(to: todo_item_path(conn, :index))
    end
  end
end
