defmodule Cali.Words.Word do
  use Ecto.Schema
  import Ecto.Changeset

  use Instructor

  @llm_doc """
  Represents a conversation in the Cali application, which is associated with a specific topic.

  ## Fields
    - `:word` The target word.
    - `:translation` The tranlsated work to the user's native language.
    - `:setence` A sentence that uses the word in context.
  """

  schema "words" do
    field :word, :string
    field :translation, :string
    field :sentence, :string

    belongs_to :conversation, Cali.Conversations.Conversation

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(word, attrs) do
    word
    |> cast(attrs, [:word, :translation, :sentence, :conversation_id])
    |> validate_required([:word, :translation, :conversation_id])
    |> foreign_key_constraint(:conversation_id)
  end
end
