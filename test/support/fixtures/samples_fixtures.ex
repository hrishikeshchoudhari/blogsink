defmodule Blogsink.SamplesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blogsink.Samples` context.
  """

  @doc """
  Generate a apple.
  """
  def apple_fixture(attrs \\ %{}) do
    {:ok, apple} =
      attrs
      |> Enum.into(%{
        name: "some name",
        origin: "some origin"
      })
      |> Blogsink.Samples.create_apple()

    apple
  end
end
