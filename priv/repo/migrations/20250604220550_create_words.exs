defmodule Cali.Repo.Migrations.CreateWords do
  use Ecto.Migration

  def change do
    create table(:words) do
      add :word, :string, null: false
      add :translation, :string, null: false
      add :sentence, :string, null: false

      add :conversation_id, references(:conversations, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:words, [:conversation_id])
  end
end
