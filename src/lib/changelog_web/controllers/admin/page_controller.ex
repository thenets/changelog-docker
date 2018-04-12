defmodule ChangelogWeb.Admin.PageController do
  use ChangelogWeb, :controller

  alias Changelog.{Episode, Newsletters, Person, Podcast, Post}

  def index(conn, _params) do
    newsletters =
      [Newsletters.community(),
       Newsletters.weekly(),
       Newsletters.nightly(),
       Newsletters.gotime(),
       Newsletters.jsparty()]
      |> Enum.map(&Newsletters.get_stats/1)

    render(conn, :index,
      newsletters: newsletters,
      draft_episodes: draft_episodes(),
      draft_posts: draft_posts(),
      members: members(),
      podcasts: podcasts())
  end

  defp draft_episodes do
    Episode.unpublished
    |> Episode.newest_last(:recorded_at)
    |> Episode.distinct_podcast
    |> Repo.all
    |> Episode.preload_podcast
  end

  defp draft_posts do
    Post.unpublished
    |> Post.newest_last(:inserted_at)
    |> Repo.all
    |> Post.preload_author
  end

  defp members do
    %{today: Repo.count(Person.joined_today()),
      slack: Repo.count(Person.in_slack()),
      total: Repo.count(Person.joined())}
  end

  defp podcasts do
    Podcast.public
    |> Podcast.oldest_first
    |> Repo.all
  end
end
