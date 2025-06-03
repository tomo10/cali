defmodule Cali.ConversationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cali.Conversations` context.
  """

  @doc """
  Generate a conversation.
  """
  def conversation_fixture(attrs \\ %{}) do
    {:ok, conversation} =
      attrs
      |> Enum.into(%{
        difficulty_level: 42,
        language: "some language",
        status: "some status",
        title: "some title"
      })
      |> Cali.Conversations.create_conversation()

    conversation
  end
end
