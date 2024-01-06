defmodule Blogsink.Samples.Apple do
  use Ecto.Schema
  import Ecto.Changeset

  schema "apples" do
    field :name, :string
    field :origin, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(apple, attrs) do
    apple
    |> cast(attrs, [:name, :origin])
    |> validate_required([:name, :origin])
  end
end
