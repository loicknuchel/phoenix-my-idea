defmodule MyIdea.Web do
  @moduledoc """
  The Web context.
  """

  import Ecto.Query, warn: false
  alias MyIdea.Repo

  alias MyIdea.Web.Project

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    Repo.all(Project)
  end

  @doc """
  Gets a single project.

  Raises `Ecto.NoResultsError` if the Project does not exist.

  ## Examples

      iex> get_project!(123)
      %Project{}

      iex> get_project!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project!(id), do: Repo.get!(Project, id)

  @doc """
  Creates a project.

  ## Examples

      iex> create_project(%{field: value})
      {:ok, %Project{}}

      iex> create_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project.

  ## Examples

      iex> update_project(project, %{field: new_value})
      {:ok, %Project{}}

      iex> update_project(project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a project.

  ## Examples

      iex> delete_project(project)
      {:ok, %Project{}}

      iex> delete_project(project)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project changes.

  ## Examples

      iex> change_project(project)
      %Ecto.Changeset{data: %Project{}}

  """
  def change_project(%Project{} = project, attrs \\ %{}) do
    Project.changeset(project, attrs)
  end

  alias MyIdea.Web.Suggestion

  @doc """
  Returns the list of suggestions.

  ## Examples

      iex> list_suggestions()
      [%Suggestion{}, ...]

  """
  def list_suggestions do
    Repo.all(Suggestion)
  end

  def list_suggestions_by_project!(project_id) do
    q = from(r in Suggestion, where: r.project_id == ^project_id)
    Repo.all(q)
  end

  @doc """
  Gets a single suggestion.

  Raises `Ecto.NoResultsError` if the Suggestion does not exist.

  ## Examples

      iex> get_suggestion!(123)
      %Suggestion{}

      iex> get_suggestion!(456)
      ** (Ecto.NoResultsError)

  """
  def get_suggestion!(id), do: Repo.get!(Suggestion, id)

  @doc """
  Creates a suggestion.

  ## Examples

      iex> create_suggestion(%{field: value})
      {:ok, %Suggestion{}}

      iex> create_suggestion(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_suggestion(attrs \\ %{}) do
    %Suggestion{}
    |> Suggestion.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a suggestion.

  ## Examples

      iex> update_suggestion(suggestion, %{field: new_value})
      {:ok, %Suggestion{}}

      iex> update_suggestion(suggestion, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_suggestion(%Suggestion{} = suggestion, attrs) do
    suggestion
    |> Suggestion.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a suggestion.

  ## Examples

      iex> delete_suggestion(suggestion)
      {:ok, %Suggestion{}}

      iex> delete_suggestion(suggestion)
      {:error, %Ecto.Changeset{}}

  """
  def delete_suggestion(%Suggestion{} = suggestion) do
    Repo.delete(suggestion)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking suggestion changes.

  ## Examples

      iex> change_suggestion(suggestion)
      %Ecto.Changeset{data: %Suggestion{}}

  """
  def change_suggestion(%Suggestion{} = suggestion, attrs \\ %{}) do
    Suggestion.changeset(suggestion, attrs)
  end
end
