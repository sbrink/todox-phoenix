defmodule Todox.TodoItemView do
  use Todox.Web, :view

  def render("toggle.json", %{ done: done }) do
    %{
      "todoItem" => %{
        "done" => done
      }
    }
  end
end
