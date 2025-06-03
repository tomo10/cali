defmodule Cali.Topics.SubTopic do
  use Ecto.Schema
  import Ecto.Changeset

  @doc """
  Represents a sub-topic within a topic, which can be used to further categorise or detail the main topic.
  """
  schema "sub_topics" do
    field :title, :string
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(sub_topic, attrs) do
    sub_topic
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
