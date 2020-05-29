defmodule MyIdeaWeb.IdeaController do
  use MyIdeaWeb, :controller

  alias MyIdea.Web
  alias MyIdea.Web.Idea

  def index(conn, %{"project_id" => project_id}) do
    ideas = Web.list_ideas()
    render(conn, "index.html", project_id: project_id, ideas: ideas)
  end

  def new(conn, %{"project_id" => project_id}) do
    changeset = Web.change_idea(%Idea{})
    render(conn, "new.html", project_id: project_id, changeset: changeset)
  end

  def create(conn, %{"project_id" => project_id, "idea" => idea_params}) do
    case Web.create_idea(Map.put(idea_params, "project_id", project_id)) do
      {:ok, idea} ->
        conn
        |> put_flash(:info, "Idea created successfully.")
        |> redirect(to: Routes.project_idea_path(conn, :show, project_id, idea))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", project_id: project_id, changeset: changeset)
    end
  end

  def show(conn, %{"project_id" => project_id, "id" => id}) do
    idea = Web.get_idea!(id)
    render(conn, "show.html", project_id: project_id, idea: idea)
  end

  def edit(conn, %{"project_id" => project_id, "id" => id}) do
    idea = Web.get_idea!(id)
    changeset = Web.change_idea(idea)
    render(conn, "edit.html", project_id: project_id, idea: idea, changeset: changeset)
  end

  def update(conn, %{"project_id" => project_id, "id" => id, "idea" => idea_params}) do
    idea = Web.get_idea!(id)

    case Web.update_idea(idea, idea_params) do
      {:ok, idea} ->
        conn
        |> put_flash(:info, "Idea updated successfully.")
        |> redirect(to: Routes.project_idea_path(conn, :show, project_id, idea))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", project_id: project_id, idea: idea, changeset: changeset)
    end
  end

  def delete(conn, %{"project_id" => project_id, "id" => id}) do
    idea = Web.get_idea!(id)
    {:ok, _idea} = Web.delete_idea(idea)

    conn
    |> put_flash(:info, "Idea deleted successfully.")
    |> redirect(to: Routes.project_idea_path(conn, :index, project_id))
  end
end
