defmodule MyIdeaWeb.SuggestionController do
  use MyIdeaWeb, :controller

  alias MyIdea.Web
  alias MyIdea.Web.Suggestion

  def index(conn, %{"project_id" => project_id}) do
    suggestions = Web.list_suggestions()
    render(conn, "index.html", project_id: project_id, suggestions: suggestions)
  end

  def new(conn, %{"project_id" => project_id}) do
    changeset = Web.change_suggestion(%Suggestion{})
    render(conn, "new.html", project_id: project_id, changeset: changeset)
  end

  def create(conn, %{"project_id" => project_id, "suggestion" => suggestion_params}) do
    case Web.create_suggestion(Map.put(suggestion_params, "project_id", project_id)) do
      {:ok, suggestion} ->
        conn
        |> put_flash(:info, "Suggestion created successfully.")
        |> redirect(to: Routes.project_suggestion_path(conn, :show, project_id, suggestion))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", project_id: project_id, changeset: changeset)
    end
  end

  def show(conn, %{"project_id" => project_id, "id" => id}) do
    suggestion = Web.get_suggestion!(id)
    render(conn, "show.html", project_id: project_id, suggestion: suggestion)
  end

  def edit(conn, %{"project_id" => project_id, "id" => id}) do
    suggestion = Web.get_suggestion!(id)
    changeset = Web.change_suggestion(suggestion)
    render(conn, "edit.html", project_id: project_id, suggestion: suggestion, changeset: changeset)
  end

  def update(conn, %{"project_id" => project_id, "id" => id, "suggestion" => suggestion_params}) do
    suggestion = Web.get_suggestion!(id)

    case Web.update_suggestion(suggestion, suggestion_params) do
      {:ok, suggestion} ->
        conn
        |> put_flash(:info, "Suggestion updated successfully.")
        |> redirect(to: Routes.project_suggestion_path(conn, :show, project_id, suggestion))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", project_id: project_id, suggestion: suggestion, changeset: changeset)
    end
  end

  def delete(conn, %{"project_id" => project_id, "id" => id}) do
    suggestion = Web.get_suggestion!(id)
    {:ok, _suggestion} = Web.delete_suggestion(suggestion)

    conn
    |> put_flash(:info, "Suggestion deleted successfully.")
    |> redirect(to: Routes.project_suggestion_path(conn, :index, project_id))
  end
end
