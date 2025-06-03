# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Cali.Repo.insert!(%Cali.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Cali.Repo
alias Cali.Topics.Topic

topics_data = [
  %{
    name: "Science",
    description: "Discussions about scientific discoveries, theories, and news."
  },
  %{name: "Art", description: "Exploring various forms of art, artists, and art history."},
  %{name: "Sport", description: "Conversations about different sports, athletes, and events."},
  %{name: "News", description: "Discussing current events and news from around the world."},
  %{
    name: "Philosophy",
    description: "Delving into philosophical questions, theories, and thinkers."
  },
  %{name: "Technology", description: "Talking about the latest in tech, gadgets, and software."},
  %{name: "Travel", description: "Sharing travel experiences, tips, and destination ideas."},
  %{name: "History", description: "Exploring historical events, figures, and periods."},
  %{name: "Music", description: "Discussing various music genres, artists, and instruments."},
  %{
    name: "Gastronomy",
    description: "Conversations about cuisine, recipes, and culinary experiences."
  }
]

Enum.each(topics_data, fn topic_attrs ->
  case Repo.get_by(Topic, name: topic_attrs.name) do
    nil -> Repo.insert!(%Topic{} |> Topic.changeset(topic_attrs))
    _existing_topic -> IO.puts("Topic \"#{topic_attrs.name}\" already exists. Skipping.")
  end
end)

IO.puts("Database seeded with topics!")
