defmodule Todox.PageController do
  use Todox.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
