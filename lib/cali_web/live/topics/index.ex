defmodule CaliWeb.Topics.Index do
  use CaliWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :topics, Cali.Topics.list_topics())}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="p-4 bg-base-100">
      <div class="card w-96 bg-base-200 shadow-xl">
        <div class="card-body">
          <h1 class="text-2xl font-bold mb-4">Topics</h1>
          <ul>
            <%= for topic <- @topics do %>
              <button class="btn m-1 bg-primary" phx-click="select-topic" phx-value-id={topic.id}>
                {topic.name}
              </button>
            <% end %>
          </ul>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("select-topic", %{"id" => id}, socket) do
    topic = Cali.Topics.get_topic!(id)

    {:ok, res} =
      Instructor.chat_completion(
        model: "gpt-4o-mini",
        response_model: Cali.Conversations.Conversation,
        messages: [
          %{
            role: "user",
            content:
              "Please give me a conversation title based on the following topic #{topic.name}."
          },
          %{role: "user", content: "The topic is about #{topic.description}."}
        ]
      )

    {:noreply, assign(socket, :selected_topic, topic)}
  end
end
