defmodule Changelog.Repo.Migrations.CreateNewsItems do
  use Ecto.Migration

  def change do
    create table(:news_items) do
      add :status, :integer, null: false, default: 0
      add :type, :integer, null: false, default: 0
      add :headline, :string, null: false
      add :url, :string, null: false
      add :published_at, :naive_datetime
      add :sponsored, :boolean, default: false
      add :newsletter, :boolean, default: true
      add :story, :text
      add :image, :string
      add :author_id, references(:people)
      add :source_id, references(:news_sources), on_delete: :nilify_all
      add :sponsor_id, references(:sponsors)

      timestamps()
    end

    create index(:news_items, [:author_id])
    create index(:news_items, [:source_id])
    create index(:news_items, [:sponsor_id])
    create index(:news_items, [:status])
    create index(:news_items, [:type])
    create index(:news_items, [:sponsored])
  end
end
