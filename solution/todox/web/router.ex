defmodule Todox.Router do
  use Todox.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Todox.Auth, repo: Todox.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Todox do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/todo_items", TodoItemController
    resources "/registration", RegistrationController, only: [:new, :create], singleton: true
    resources "/session", SessionController, only: [:new, :create, :delete], singleton: true
  end

  scope "/api", Todox do
    pipe_through :api

    patch "/todo_items/:id/toggle", TodoItemController, :toggle
  end
end
