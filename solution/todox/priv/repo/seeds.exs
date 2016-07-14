# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs

alias Todox.{ Repo, TodoItem, User }

users = [
  %{
    username: "lazy-guy",
    password: "seedpass",
    todo_items: [
      %{ content: "Go to lunch" },
      %{ content: "Waste some time" }
    ]
  },

  %{
    username: "workaholic",
    password: "seedpass",
    todo_items: [
      %{ content: "Work my ass off", done: true },
      %{ content: "Work even more", done: true },
      %{ content: "Work till dawn", done: true }
    ]
  }
]

Enum.each users, fn %{ username: username } = user_params ->
  user = Repo.get_by(User, username: username)
  user = user || Repo.insert!(User.registration_changeset(%User{}, user_params))

  Enum.each user_params.todo_items, fn %{ content: content} = todo_item_params ->
    todo_item = Repo.get_by(TodoItem, user_id: user.id, content: content)
    todo_item ||
      Repo.insert!(TodoItem.changeset(%TodoItem{ user: user }, todo_item_params))
  end
end
