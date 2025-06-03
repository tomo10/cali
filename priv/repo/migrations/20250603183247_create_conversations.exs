defmodule Cali.Repo.Migrations.CreateConversations do
  use Ecto.Migration

  def change do
    create table(:conversations) do
      add :title, :string
      add :difficulty_level, :integer
      add :language, :string
      add :status, :string, default: "active"

      timestamps(type: :utc_datetime)
    end
  end
end
