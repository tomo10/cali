defmodule CaliWeb.Tablet.Index do
  use CaliWeb, :live_view
  alias Cali.Words

  @voices [
    "Shelley (Spanish (Mexico))",
    "Daniel (English (United Kingdom))",
    "Samantha",
    "Zuzana",
    "Google español",
    "Flo (Spanish (Mexico))",
    "Flo (Spanish (Spain))",
    "Thomas"
  ]

  @impl true
  def mount(_params, _session, socket) do
    words = Words.list_words()

    {:ok,
     assign(socket, words: words, voices: @voices, selected_voice: "Shelley (Spanish (Mexico))")}
  end

  @impl true
  def handle_event("speak-word", %{"text" => text}, socket) do
    {:noreply,
     push_event(socket, "Voice", %{
       text: text,
       lang: "es-ES",
       voiceName: socket.assigns.selected_voice
     })}
  end

  @impl true
  def handle_event("select-voice", %{"voice" => voice}, socket) do
    {:noreply, assign(socket, selected_voice: voice)}
  end
end
