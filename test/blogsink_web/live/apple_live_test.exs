defmodule BlogsinkWeb.AppleLiveTest do
  use BlogsinkWeb.ConnCase

  import Phoenix.LiveViewTest
  import Blogsink.SamplesFixtures

  @create_attrs %{name: "some name", origin: "some origin"}
  @update_attrs %{name: "some updated name", origin: "some updated origin"}
  @invalid_attrs %{name: nil, origin: nil}

  defp create_apple(_) do
    apple = apple_fixture()
    %{apple: apple}
  end

  describe "Index" do
    setup [:create_apple]

    test "lists all apples", %{conn: conn, apple: apple} do
      {:ok, _index_live, html} = live(conn, ~p"/apples")

      assert html =~ "Listing Apples"
      assert html =~ apple.name
    end

    test "saves new apple", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/apples")

      assert index_live |> element("a", "New Apple") |> render_click() =~
               "New Apple"

      assert_patch(index_live, ~p"/apples/new")

      assert index_live
             |> form("#apple-form", apple: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#apple-form", apple: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/apples")

      html = render(index_live)
      assert html =~ "Apple created successfully"
      assert html =~ "some name"
    end

    test "updates apple in listing", %{conn: conn, apple: apple} do
      {:ok, index_live, _html} = live(conn, ~p"/apples")

      assert index_live |> element("#apples-#{apple.id} a", "Edit") |> render_click() =~
               "Edit Apple"

      assert_patch(index_live, ~p"/apples/#{apple}/edit")

      assert index_live
             |> form("#apple-form", apple: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#apple-form", apple: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/apples")

      html = render(index_live)
      assert html =~ "Apple updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes apple in listing", %{conn: conn, apple: apple} do
      {:ok, index_live, _html} = live(conn, ~p"/apples")

      assert index_live |> element("#apples-#{apple.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#apples-#{apple.id}")
    end
  end

  describe "Show" do
    setup [:create_apple]

    test "displays apple", %{conn: conn, apple: apple} do
      {:ok, _show_live, html} = live(conn, ~p"/apples/#{apple}")

      assert html =~ "Show Apple"
      assert html =~ apple.name
    end

    test "updates apple within modal", %{conn: conn, apple: apple} do
      {:ok, show_live, _html} = live(conn, ~p"/apples/#{apple}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Apple"

      assert_patch(show_live, ~p"/apples/#{apple}/show/edit")

      assert show_live
             |> form("#apple-form", apple: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#apple-form", apple: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/apples/#{apple}")

      html = render(show_live)
      assert html =~ "Apple updated successfully"
      assert html =~ "some updated name"
    end
  end
end
