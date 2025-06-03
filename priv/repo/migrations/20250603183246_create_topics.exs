defmodule Cali.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :name, :string
      add :description, :text

      timestamps(type: :utc_datetime)
    end
  end
end
