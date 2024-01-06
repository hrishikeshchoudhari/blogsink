defmodule Blogsink.SamplesTest do
  use Blogsink.DataCase

  alias Blogsink.Samples

  describe "apples" do
    alias Blogsink.Samples.Apple

    import Blogsink.SamplesFixtures

    @invalid_attrs %{name: nil, origin: nil}

    test "list_apples/0 returns all apples" do
      apple = apple_fixture()
      assert Samples.list_apples() == [apple]
    end

    test "get_apple!/1 returns the apple with given id" do
      apple = apple_fixture()
      assert Samples.get_apple!(apple.id) == apple
    end

    test "create_apple/1 with valid data creates a apple" do
      valid_attrs = %{name: "some name", origin: "some origin"}

      assert {:ok, %Apple{} = apple} = Samples.create_apple(valid_attrs)
      assert apple.name == "some name"
      assert apple.origin == "some origin"
    end

    test "create_apple/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Samples.create_apple(@invalid_attrs)
    end

    test "update_apple/2 with valid data updates the apple" do
      apple = apple_fixture()
      update_attrs = %{name: "some updated name", origin: "some updated origin"}

      assert {:ok, %Apple{} = apple} = Samples.update_apple(apple, update_attrs)
      assert apple.name == "some updated name"
      assert apple.origin == "some updated origin"
    end

    test "update_apple/2 with invalid data returns error changeset" do
      apple = apple_fixture()
      assert {:error, %Ecto.Changeset{}} = Samples.update_apple(apple, @invalid_attrs)
      assert apple == Samples.get_apple!(apple.id)
    end

    test "delete_apple/1 deletes the apple" do
      apple = apple_fixture()
      assert {:ok, %Apple{}} = Samples.delete_apple(apple)
      assert_raise Ecto.NoResultsError, fn -> Samples.get_apple!(apple.id) end
    end

    test "change_apple/1 returns a apple changeset" do
      apple = apple_fixture()
      assert %Ecto.Changeset{} = Samples.change_apple(apple)
    end
  end
end
