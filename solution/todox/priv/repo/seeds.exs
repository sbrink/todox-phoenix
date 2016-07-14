# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs

alias Todox.{ Repo, TodoItem }

todo_items = [
  %{ content: "Go to lunch" },
  %{ content: "Waste some time" },
  %{ content: "Work my ass off", done: true },
  %{ content: "Work even more", done: true },
  %{ content: "Work till dawn", done: true }
]

Enum.each todo_items, fn %{ content: content} = todo_item_params ->
  todo_item = Repo.get_by(TodoItem, content: content)
  todo_item ||
    Repo.insert!(TodoItem.changeset(%TodoItem{ }, todo_item_params))
end
