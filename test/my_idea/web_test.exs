defmodule MyIdea.WebTest do
  use MyIdea.DataCase

  alias MyIdea.Web

  describe "projects" do
    alias MyIdea.Web.Project

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Web.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Web.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Web.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Web.create_project(@valid_attrs)
      assert project.name == "some name"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Web.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, %Project{} = project} = Web.update_project(project, @update_attrs)
      assert project.name == "some updated name"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Web.update_project(project, @invalid_attrs)
      assert project == Web.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Web.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Web.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Web.change_project(project)
    end
  end

  describe "suggestions" do
    alias MyIdea.Web.Project
    alias MyIdea.Web.Suggestion

    @project_valid_attrs %{name: "some name"}
    @valid_attrs %{description: "some description", title: "some title", project_id: nil}
    @update_attrs %{description: "some updated description", title: "some updated title", project_id: nil}
    @invalid_attrs %{description: nil, title: nil, project_id: nil}

    def suggestion_fixture(attrs \\ %{}) do
      {:ok, %Project{} = project} = Web.create_project(@project_valid_attrs)
      {:ok, suggestion} =
        attrs
        |> Enum.into(%{@valid_attrs | project_id: project.id})
        |> Web.create_suggestion()

      suggestion
    end

    test "list_suggestions/0 returns all suggestions" do
      suggestion = suggestion_fixture()
      assert Web.list_suggestions() == [suggestion]
    end

    test "get_suggestion!/1 returns the suggestion with given id" do
      suggestion = suggestion_fixture()
      assert Web.get_suggestion!(suggestion.id) == suggestion
    end

    test "create_suggestion/1 with valid data creates a suggestion" do
      {:ok, %Project{} = project} = Web.create_project(@project_valid_attrs)
      assert {:ok, %Suggestion{} = suggestion} = Web.create_suggestion(%{@valid_attrs | project_id: project.id})
      assert suggestion.description == "some description"
      assert suggestion.title == "some title"
    end

    test "create_suggestion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Web.create_suggestion(@invalid_attrs)
    end

    test "update_suggestion/2 with valid data updates the suggestion" do
      suggestion = suggestion_fixture()
      assert {:ok, %Suggestion{} = suggestion} = Web.update_suggestion(suggestion, %{@update_attrs | project_id: suggestion.project_id})
      assert suggestion.description == "some updated description"
      assert suggestion.title == "some updated title"
    end

    test "update_suggestion/2 with invalid data returns error changeset" do
      suggestion = suggestion_fixture()
      assert {:error, %Ecto.Changeset{}} = Web.update_suggestion(suggestion, %{@invalid_attrs | project_id: suggestion.project_id})
      assert suggestion == Web.get_suggestion!(suggestion.id)
    end

    test "delete_suggestion/1 deletes the suggestion" do
      suggestion = suggestion_fixture()
      assert {:ok, %Suggestion{}} = Web.delete_suggestion(suggestion)
      assert_raise Ecto.NoResultsError, fn -> Web.get_suggestion!(suggestion.id) end
    end

    test "change_suggestion/1 returns a suggestion changeset" do
      suggestion = suggestion_fixture()
      assert %Ecto.Changeset{} = Web.change_suggestion(suggestion)
    end
  end
end
