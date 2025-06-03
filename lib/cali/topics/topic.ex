defmodule Cali.Topics.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  use Instructor

  alias Cali.Conversations.Conversation
  alias Cali.Topics.SubTopic

  @llm_doc """
  Represents a conversation in the Cali application, which is associated with a specific topic.

  ## Fields
    - `:title` The title of the topic.
    - `:description` The description of the topic.
    - `:sub_topics`:
      - `:title` The title of the subtopic.
      - `:description` The description of the subtopic.
  """

  schema "topics" do
    field :title, :string
    field :description, :string

    embeds_many :sub_topics, SubTopic, on_replace: :delete
    has_many :conversations, Conversation

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
