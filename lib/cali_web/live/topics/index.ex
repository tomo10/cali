defmodule CaliWeb.Topics.Index do
  use CaliWeb, :live_view
  alias Cali.Topics.Topic
  alias Cali.Conversations.Conversation

  @dummy_data [
    %Cali.Topics.SubTopic{
      id: 1,
      title: "Music Genres",
      description:
        "A discussion on various music genres including pop, rock, jazz, classical, and hip-hop.",
      inserted_at: ~U[2024-07-20 12:00:00Z],
      updated_at: ~U[2024-07-20 12:00:00Z]
    },
    %Cali.Topics.SubTopic{
      id: 2,
      title: "Famous Artists",
      description:
        "Insights into well-known artists from different genres, including their influence and impact on music.",
      inserted_at: ~U[2024-07-20 12:00:00Z],
      updated_at: ~U[2024-07-20 12:00:00Z]
    },
    %Cali.Topics.SubTopic{
      id: 3,
      title: "Musical Instruments",
      description:
        "Discussion about various musical instruments and their roles in different genres of music.",
      inserted_at: ~U[2024-07-20 12:00:00Z],
      updated_at: ~U[2024-07-20 12:00:00Z]
    },
    %Cali.Topics.SubTopic{
      id: 4,
      title: "Music Theory",
      description:
        "An overview of music theory concepts, including scales, harmony, and composition techniques.",
      inserted_at: ~U[2024-07-20 12:00:00Z],
      updated_at: ~U[2024-07-20 12:00:00Z]
    },
    %Cali.Topics.SubTopic{
      id: 5,
      title: "Cultural Influence of Music",
      description:
        "Exploring how music influences and is influenced by culture, traditions, and social movements.",
      inserted_at: ~U[2024-07-20 12:00:00Z],
      updated_at: ~U[2024-07-20 12:00:00Z]
    }
  ]

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       topics: Cali.Topics.list_topics(),
       sub_topics: [],
       topic_title: "",
       conversation: nil
     )}
  end

  @impl true
  def handle_event("select-topic", %{"id" => id}, socket) do
    topic = Cali.Topics.get_topic!(id)

    {:ok, topic} =
      Instructor.chat_completion(
        model: "gpt-4o-mini",
        response_model: Topic,
        messages: [
          %{
            role: "user",
            content:
              "Please give me a topic and subtopics in jsonb for the following topic #{topic.title}."
          },
          %{
            role: "user",
            content: "The subtopics will be 2 examples based on #{topic.description}."
          }
        ]
      )

    {:noreply, assign(socket, sub_topics: topic.sub_topics, topic_title: topic.description)}
  end

  @impl true
  def handle_event("select-sub-topic", %{"id" => id}, socket) do
    sub_topic = Enum.find(socket.assigns.sub_topics, &(&1.id == String.to_integer(id)))
    dbg(sub_topic)

    {:ok, conversation} =
      Instructor.chat_completion(
        model: "gpt-4o-mini",
        response_model: Conversation,
        messages: [
          %{
            role: "user",
            content:
              "Please give me a conversation for the following topic #{sub_topic.title}. The translation field array should have at least a length of 5 and can be longer if it helps with context."
          },
          %{
            role: "user",
            content:
              "The translation field is Spanish (LATAM). The native field is English. The translation and native fields should be arrays of strings of equal length."
          },
          %{
            role: "user",
            content:
              "Create translation with a difficulty of 1 / 10 (v basic speaker). The style of the prose should be like an article in a reputable magazine. Importantly the arrays of strings should flow in a normal coherent manner. Each should follow the last."
          }
        ]
      )

    dbg(conversation)

    {:noreply, assign(socket, conversation: conversation)}
  end

  @impl true
  def handle_event("select-word", %{"word" => word}, socket) do
    dbg(word)

    {:noreply, socket}
  end
end
