defmodule Cali.Repo.Migrations.CreateConversations do
  use Ecto.Migration

  def change do
    create table(:conversations) do
      add :title, :string
      add :difficulty_level, :integer
      add :language, :string
      add :native, {:array, :text}
      add :translation, {:array, :text}
      add :status, :string, default: "active"
      add :topic_id, references(:topics, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:conversations, [:topic_id])
  end
end
