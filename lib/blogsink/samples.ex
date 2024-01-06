defmodule Blogsink.Samples do
  @moduledoc """
  The Samples context.
  """

  import Ecto.Query, warn: false
  alias Blogsink.Repo

  alias Blogsink.Samples.Apple

  @doc """
  Returns the list of apples.

  ## Examples

      iex> list_apples()
      [%Apple{}, ...]

  """
  def list_apples do
    Repo.all(Apple)
  end

  @doc """
  Gets a single apple.

  Raises `Ecto.NoResultsError` if the Apple does not exist.

  ## Examples

      iex> get_apple!(123)
      %Apple{}

      iex> get_apple!(456)
      ** (Ecto.NoResultsError)

  """
  def get_apple!(id), do: Repo.get!(Apple, id)

  @doc """
  Creates a apple.

  ## Examples

      iex> create_apple(%{field: value})
      {:ok, %Apple{}}

      iex> create_apple(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_apple(attrs \\ %{}) do
    %Apple{}
    |> Apple.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a apple.

  ## Examples

      iex> update_apple(apple, %{field: new_value})
      {:ok, %Apple{}}

      iex> update_apple(apple, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_apple(%Apple{} = apple, attrs) do
    apple
    |> Apple.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a apple.

  ## Examples

      iex> delete_apple(apple)
      {:ok, %Apple{}}

      iex> delete_apple(apple)
      {:error, %Ecto.Changeset{}}

  """
  def delete_apple(%Apple{} = apple) do
    Repo.delete(apple)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking apple changes.

  ## Examples

      iex> change_apple(apple)
      %Ecto.Changeset{data: %Apple{}}

  """
  def change_apple(%Apple{} = apple, attrs \\ %{}) do
    Apple.changeset(apple, attrs)
  end
end
