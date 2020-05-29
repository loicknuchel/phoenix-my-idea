defmodule MyIdea.Web.Suggestion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "suggestions" do
    field :description, :string
    field :title, :string
    field :project_id, :id

    timestamps()
  end

  @doc false
  def changeset(suggestion, attrs) do
    suggestion
    |> cast(attrs, [:title, :description, :project_id])
    |> validate_required([:title, :description, :project_id])
    |> foreign_key_constraint(:project_id)
  end
end
