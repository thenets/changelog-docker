defmodule Changelog.EpisodeHost do
  use Changelog.Data

  alias Changelog.{Episode, Person}

  schema "episode_hosts" do
    field :position, :integer
    field :delete, :boolean, virtual: true

    belongs_to :person, Person
    belongs_to :episode, Episode

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(position episode_id person_id delete))
    |> validate_required([:position])
    |> mark_for_deletion()
  end

  def by_position do
    from p in __MODULE__, order_by: p.position
  end

  def build_and_preload({person, position}) do
    %__MODULE__{position: position, person_id: person.id} |> Repo.preload(:person)
  end

  defp mark_for_deletion(changeset) do
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end
