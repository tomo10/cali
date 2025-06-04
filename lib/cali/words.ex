defmodule Cali.Words do
  import Ecto.Query, warn: false
  alias Cali.Repo

  alias Cali.Words.Word

  def create_word(attrs \\ %{}) do
    %Word{}
    |> Word.changeset(attrs)
    |> Repo.insert()
  end

  def list_words do
    Repo.all(Word)
  end
end
