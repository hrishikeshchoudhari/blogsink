defmodule Blogsink.Repo.Migrations.CreateApples do
  use Ecto.Migration

  def change do
    create table(:apples) do
      add :name, :string
      add :origin, :string

      timestamps(type: :utc_datetime)
    end
  end
end
