defmodule MyIdea.Repo.Migrations.CreateSuggestions do
  use Ecto.Migration

  def change do
    create table(:suggestions) do
      add :title, :string
      add :description, :text
      add :project_id, references(:projects, on_delete: :delete_all)

      timestamps()
    end

    create index(:suggestions, [:project_id])
  end
end
