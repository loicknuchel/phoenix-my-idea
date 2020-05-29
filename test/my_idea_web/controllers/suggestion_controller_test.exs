defmodule MyIdeaWeb.SuggestionControllerTest do
  use MyIdeaWeb.ConnCase

  alias MyIdea.Web

  @project_create_attrs %{name: "some name"}
  @create_attrs %{description: "some description", title: "some title", project_id: nil}
  @update_attrs %{description: "some updated description", title: "some updated title", project_id: nil}
  @invalid_attrs %{description: nil, title: nil, project_id: nil}

  def fixture(:suggestion) do
    {:ok, project} = Web.create_project(@project_create_attrs)
    {:ok, suggestion} = Web.create_suggestion(%{@create_attrs | project_id: project.id})
    suggestion
  end

  describe "index" do
    test "lists all suggestions", %{conn: conn} do
      {:ok, project} = Web.create_project(@project_create_attrs)
      conn = get(conn, Routes.project_suggestion_path(conn, :index, project.id))
      assert html_response(conn, 200) =~ "Listing Suggestions"
    end
  end

  describe "new suggestion" do
    test "renders form", %{conn: conn} do
      {:ok, project} = Web.create_project(@project_create_attrs)
      conn = get(conn, Routes.project_suggestion_path(conn, :new, project.id))
      assert html_response(conn, 200) =~ "New Suggestion"
    end
  end

  describe "create suggestion" do
    test "redirects to show when data is valid", %{conn: conn} do
      {:ok, project} = Web.create_project(@project_create_attrs)
      conn = post(conn, Routes.project_suggestion_path(conn, :create, project.id), suggestion: %{@create_attrs | project_id: project.id})

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.project_suggestion_path(conn, :show, project.id, id)

      conn = get(conn, Routes.project_suggestion_path(conn, :show, project.id, id))
      assert html_response(conn, 200) =~ "Show Suggestion"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      {:ok, project} = Web.create_project(@project_create_attrs)
      conn = post(conn, Routes.project_suggestion_path(conn, :create, project.id), suggestion: %{@invalid_attrs | project_id: project.id})
      assert html_response(conn, 200) =~ "New Suggestion"
    end
  end

  describe "edit suggestion" do
    setup [:create_suggestion]

    test "renders form for editing chosen suggestion", %{conn: conn, suggestion: suggestion} do
      conn = get(conn, Routes.project_suggestion_path(conn, :edit, suggestion.project_id, suggestion))
      assert html_response(conn, 200) =~ "Edit Suggestion"
    end
  end

  describe "update suggestion" do
    setup [:create_suggestion]

    test "redirects when data is valid", %{conn: conn, suggestion: suggestion} do
      conn = put(conn, Routes.project_suggestion_path(conn, :update, suggestion.project_id, suggestion), suggestion: %{@update_attrs | project_id: suggestion.project_id})
      assert redirected_to(conn) == Routes.project_suggestion_path(conn, :show, suggestion.project_id, suggestion)

      conn = get(conn, Routes.project_suggestion_path(conn, :show, suggestion.project_id, suggestion))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, suggestion: suggestion} do
      conn = put(conn, Routes.project_suggestion_path(conn, :update, suggestion.project_id, suggestion), suggestion: %{@invalid_attrs | project_id: suggestion.project_id})
      assert html_response(conn, 200) =~ "Edit Suggestion"
    end
  end

  describe "delete suggestion" do
    setup [:create_suggestion]

    test "deletes chosen suggestion", %{conn: conn, suggestion: suggestion} do
      conn = delete(conn, Routes.project_suggestion_path(conn, :delete, suggestion.project_id, suggestion))
      assert redirected_to(conn) == Routes.project_suggestion_path(conn, :index, suggestion.project_id)
      assert_error_sent 404, fn ->
        get(conn, Routes.project_suggestion_path(conn, :show, suggestion.project_id, suggestion))
      end
    end
  end

  defp create_suggestion(_) do
    suggestion = fixture(:suggestion)
    %{suggestion: suggestion}
  end
end
