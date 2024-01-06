defmodule Blogsink.SchoolFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blogsink.School` context.
  """

  @doc """
  Generate a student.
  """
  def student_fixture(attrs \\ %{}) do
    {:ok, student} =
      attrs
      |> Enum.into(%{
        name: "some name",
        origin: "some origin"
      })
      |> Blogsink.School.create_student()

    student
  end
end
