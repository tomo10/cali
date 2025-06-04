defmodule Cali.Conversations.Conversation do
  use Ecto.Schema
  import Ecto.Changeset

  use Instructor
  alias Cali.Topics.Topic

  @llm_doc """
  Represents a conversation in the Cali application, which is associated with a specific topic.

  ## Fields
    - `:title` The title of the conversation.
    - `:language` The language of the conversation.
    - `:difficulty_level` The difficulty level of the conversation, ranging from 1 to 10.
    - `:native` The native language of the conversation, stored as an array of strings each string representing a sentence.
    - `:translation` The translation of the conversation, stored as an array of strings each string representing a sentence.
    - `:status` The status of the conversation, which can be `:active`, `:completed`, or `:archived`.
  """

  schema "conversations" do
    field :title, :string
    field :language, :string
    field :difficulty_level, :integer
    field :native, {:array, :string}
    field :translation, {:array, :string}
    field :status, Ecto.Enum, values: [:active, :completed, :archived], default: :active

    belongs_to :topic, Topic

    timestamps(type: :utc_datetime)
  end

  # todo think will want to make native and translation fields optional or an embedded_schema

  @doc false
  def changeset(conversation, attrs) do
    conversation
    |> cast(attrs, [:title, :difficulty_level, :language, :status, :topic_id])
    |> validate_required([:title, :difficulty_level, :language, :status, :topic_id])
    |> validate_number(:difficulty_level, greater_than: 0, less_than_or_equal_to: 10)
    |> foreign_key_constraint(:topic_id)
  end
end
