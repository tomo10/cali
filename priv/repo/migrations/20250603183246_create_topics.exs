defmodule Cali.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :title, :string
      add :description, :text
      add :sub_topics, :jsonb, default: fragment("'[]'::jsonb")

      timestamps(type: :utc_datetime)
    end
  end
end
