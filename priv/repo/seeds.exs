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
    title: "Science",
    description: "Discussions about scientific discoveries, theories, and news."
  },
  %{title: "Art", description: "Exploring various forms of art, artists, and art history."},
  %{
    title: "Sport",
    description:
      "Conversations about different sports, athletes, and events. Can be news, hisotry of sport, or analysis of sports."
  },
  %{title: "News", description: "Give summaries of top recent news stories."},
  %{
    title: "Philosophy",
    description: "Delving into philosophical questions, theories, and thinkers."
  },
  %{title: "Technology", description: "Talking about the latest in tech, gadgets, and software."},
  %{title: "Travel", description: "Sharing travel experiences, tips, and destination ideas."},
  %{title: "History", description: "Exploring historical events, figures, and periods."},
  %{title: "Music", description: "Discussing various music genres, artists, and instruments."},
  %{
    title: "Gastronomy",
    description: "Conversations about cuisine, recipes, and culinary experiences."
  },
  %{
    title: "Environment",
    description: "Topics about climate change, sustainability, and protecting nature."
  },
  %{
    title: "Literature",
    description: "Discussing books, authors, literary genres, and storytelling."
  },
  %{
    title: "Education",
    description: "Conversations about learning, teaching methods, and schools."
  },
  %{
    title: "Business",
    description: "Exploring entrepreneurship, startups, and business strategies."
  },
  %{
    title: "Health",
    description: "Topics about physical and mental health, wellness, and medicine."
  },
  %{
    title: "Fashion",
    description: "Discussing trends, designers, and the world of clothing and style."
  },
  %{
    title: "Cinema",
    description: "Conversations about movies, directors, actors, and film history."
  },
  %{
    title: "Politics",
    description: "Discussing political systems, elections, and current affairs."
  },
  %{
    title: "Relationships",
    description: "Topics about friendship, family, love, and social dynamics."
  },
  %{
    title: "Science Fiction",
    description: "Exploring futuristic concepts, technology, and imaginative worlds in fiction."
  }
]

Enum.each(topics_data, fn topic_attrs ->
  case Repo.get_by(Topic, title: topic_attrs.title) do
    nil -> Repo.insert!(%Topic{} |> Topic.changeset(topic_attrs))
    _existing_topic -> IO.puts("Topic \"#{topic_attrs.title}\" already exists. Skipping.")
  end
end)

IO.puts("Database seeded with topics!")
