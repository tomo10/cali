defmodule Cali.Conversations.Conversation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "conversations" do
    field :title, :string
    field :language, :string
    field :difficulty_level, :integer
    field :status, Ecto.Enum, values: [:active, :completed, :archived], default: :active

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(conversation, attrs) do
    conversation
    |> cast(attrs, [:title, :difficulty_level, :language, :status])
    |> validate_required([:title, :difficulty_level, :language, :status])
    |> validate_number(:difficulty_level, greater_than: 0, less_than_or_equal_to: 10)
  end
end
