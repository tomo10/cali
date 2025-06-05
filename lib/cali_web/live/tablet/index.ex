defmodule CaliWeb.Tablet.Index do
  use CaliWeb, :live_view
  alias Cali.Words

  @impl true
  def mount(_params, _session, socket) do
    words = Words.list_words()

    {:ok, assign(socket, :words, words)}
  end

  @impl true
  def handle_event("speak-word", %{"text" => text}, socket) do
    dbg(text)
    {:noreply, push_event(socket, "Voice", %{text: text, lang: "es-ES"})}
  end
end
