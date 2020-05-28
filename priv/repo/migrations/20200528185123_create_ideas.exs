defmodule MyIdea.Repo.Migrations.CreateIdeas do
  use Ecto.Migration

  def change do
    create table(:ideas) do
      add :title, :string
      add :description, :text
      add :project_id, references(:projects, on_delete: :nothing)

      timestamps()
    end

    create index(:ideas, [:project_id])
  end
end
