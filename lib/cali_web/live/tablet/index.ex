defmodule CaliWeb.Tablet.Index do
  use CaliWeb, :live_view
  alias Cali.Words

  @impl true
  def mount(_params, _session, socket) do
    words = Words.list_words()

    {:ok, assign(socket, :words, words)}
  end
end
