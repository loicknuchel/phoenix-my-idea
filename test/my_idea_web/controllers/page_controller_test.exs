defmodule MyIdeaWeb.PageControllerTest do
  use MyIdeaWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to My Idea!"
  end
end
