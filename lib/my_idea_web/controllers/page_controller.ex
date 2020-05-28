defmodule MyIdeaWeb.PageController do
  use MyIdeaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
