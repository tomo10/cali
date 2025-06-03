defmodule CaliWeb.Topics.Index do
  use CaliWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, topics: Cali.Topics.list_topics(), sub_topics: [], topic_title: "")}
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
                {topic.title}
              </button>
            <% end %>
          </ul>
        </div>
      </div>
    </div>
    <ul class="list bg-base-100 rounded-box shadow-md">
      <li class="p-4 pb-2 text-xs opacity-60 tracking-wide">{@topic_title}</li>

      <li :for={sub_topic <- @sub_topics} class="list-row">
        <div class="text-4xl font-thin opacity-30 tabular-nums">
          {Integer.to_string(sub_topic.id)}
        </div>
        <div>
          <img
            class="size-10 rounded-box"
            src="https://img.daisyui.com/images/profile/demo/1@94.webp"
          />
        </div>
        <div class="list-col-grow">
          <div>{sub_topic.title}</div>
          <div class="text-xs uppercase font-semibold opacity-60">{sub_topic.description}</div>
        </div>
        <button class="btn btn-square btn-ghost">
          <svg class="size-[1.2em]" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
            <g
              strokeLinejoin="round"
              strokeLinecap="round"
              strokeWidth="2"
              fill="none"
              stroke="currentColor"
            >
              <path d="M6 3L20 12 6 21 6 3z"></path>
            </g>
          </svg>
        </button>
      </li>
    </ul>
    """
  end

  @impl true
  def handle_event("select-topic", %{"id" => id}, socket) do
    topic = Cali.Topics.get_topic!(id)

    {:ok, topic} =
      Instructor.chat_completion(
        model: "gpt-4o-mini",
        response_model: Cali.Topics.Topic,
        messages: [
          %{
            role: "user",
            content:
              "Please give me a topic and subtopics in jsonb for the following topic #{topic.title}."
          },
          %{
            role: "user",
            content:
              "The subtopics will be 5 examples and a variety based on #{topic.description}."
          }
        ]
      )

    dbg(topic)

    {:noreply, assign(socket, sub_topics: topic.sub_topics, topic_title: topic.description)}
  end
end
