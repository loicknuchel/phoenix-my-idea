defmodule MyIdeaWeb.IdeaControllerTest do
  use MyIdeaWeb.ConnCase

  alias MyIdea.Web

  @project_create_attrs %{name: "some name"}
  @create_attrs %{description: "some description", title: "some title", project_id: nil}
  @update_attrs %{description: "some updated description", title: "some updated title", project_id: nil}
  @invalid_attrs %{description: nil, title: nil, project_id: nil}

  def fixture(:idea) do
    {:ok, project} = Web.create_project(@project_create_attrs)
    {:ok, idea} = Web.create_idea(%{@create_attrs | project_id: project.id})
    idea
  end

  describe "index" do
    test "lists all ideas", %{conn: conn} do
      {:ok, project} = Web.create_project(@project_create_attrs)
      conn = get(conn, Routes.project_idea_path(conn, :index, project.id))
      assert html_response(conn, 200) =~ "Listing Ideas"
    end
  end

  describe "new idea" do
    test "renders form", %{conn: conn} do
      {:ok, project} = Web.create_project(@project_create_attrs)
      conn = get(conn, Routes.project_idea_path(conn, :new, project.id))
      assert html_response(conn, 200) =~ "New Idea"
    end
  end

  describe "create idea" do
    test "redirects to show when data is valid", %{conn: conn} do
      {:ok, project} = Web.create_project(@project_create_attrs)
      conn = post(conn, Routes.project_idea_path(conn, :create, project.id), idea: %{@create_attrs | project_id: project.id})

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.project_idea_path(conn, :show, project.id, id)

      conn = get(conn, Routes.project_idea_path(conn, :show, project.id, id))
      assert html_response(conn, 200) =~ "Show Idea"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      {:ok, project} = Web.create_project(@project_create_attrs)
      conn = post(conn, Routes.project_idea_path(conn, :create, project.id), idea: %{@invalid_attrs | project_id: project.id})
      assert html_response(conn, 200) =~ "New Idea"
    end
  end

  describe "edit idea" do
    setup [:create_idea]

    test "renders form for editing chosen idea", %{conn: conn, idea: idea} do
      conn = get(conn, Routes.project_idea_path(conn, :edit, idea.project_id, idea))
      assert html_response(conn, 200) =~ "Edit Idea"
    end
  end

  describe "update idea" do
    setup [:create_idea]

    test "redirects when data is valid", %{conn: conn, idea: idea} do
      conn = put(conn, Routes.project_idea_path(conn, :update, idea.project_id, idea), idea: %{@update_attrs | project_id: idea.project_id})
      assert redirected_to(conn) == Routes.project_idea_path(conn, :show, idea.project_id, idea)

      conn = get(conn, Routes.project_idea_path(conn, :show, idea.project_id, idea))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, idea: idea} do
      conn = put(conn, Routes.project_idea_path(conn, :update, idea.project_id, idea), idea: %{@invalid_attrs | project_id: idea.project_id})
      assert html_response(conn, 200) =~ "Edit Idea"
    end
  end

  describe "delete idea" do
    setup [:create_idea]

    test "deletes chosen idea", %{conn: conn, idea: idea} do
      conn = delete(conn, Routes.project_idea_path(conn, :delete, idea.project_id, idea))
      assert redirected_to(conn) == Routes.project_idea_path(conn, :index, idea.project_id)
      assert_error_sent 404, fn ->
        get(conn, Routes.project_idea_path(conn, :show, idea.project_id, idea))
      end
    end
  end

  defp create_idea(_) do
    idea = fixture(:idea)
    %{idea: idea}
  end
end
