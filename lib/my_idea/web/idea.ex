defmodule MyIdea.Web.Idea do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ideas" do
    field :description, :string
    field :title, :string
    field :project_id, :id

    timestamps()
  end

  @doc false
  def changeset(idea, attrs) do
    idea
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
