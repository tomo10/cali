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
              <li class="mb-2 badge badge-primary">{topic.name}</li>
            <% end %>
          </ul>
        </div>
      </div>
    </div>
    """
  end
end
