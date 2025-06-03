defmodule Cali.TopicsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cali.Topics` context.
  """

  @doc """
  Generate a topic.
  """
  def topic_fixture(attrs \\ %{}) do
    {:ok, topic} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> Cali.Topics.create_topic()

    topic
  end
end
