defmodule BlogsinkWeb.TomatoLiveTest do
  use BlogsinkWeb.ConnCase

  import Phoenix.LiveViewTest
  import Blogsink.SamplesFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_tomato(_) do
    tomato = tomato_fixture()
    %{tomato: tomato}
  end

  describe "Index" do
    setup [:create_tomato]

    test "lists all tomatoes", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/tomatoes")

      assert html =~ "Listing Tomatoes"
    end

    test "saves new tomato", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/tomatoes")

      assert index_live |> element("a", "New Tomato") |> render_click() =~
               "New Tomato"

      assert_patch(index_live, ~p"/tomatoes/new")

      assert index_live
             |> form("#tomato-form", tomato: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#tomato-form", tomato: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tomatoes")

      html = render(index_live)
      assert html =~ "Tomato created successfully"
    end

    test "updates tomato in listing", %{conn: conn, tomato: tomato} do
      {:ok, index_live, _html} = live(conn, ~p"/tomatoes")

      assert index_live |> element("#tomatoes-#{tomato.id} a", "Edit") |> render_click() =~
               "Edit Tomato"

      assert_patch(index_live, ~p"/tomatoes/#{tomato}/edit")

      assert index_live
             |> form("#tomato-form", tomato: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#tomato-form", tomato: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tomatoes")

      html = render(index_live)
      assert html =~ "Tomato updated successfully"
    end

    test "deletes tomato in listing", %{conn: conn, tomato: tomato} do
      {:ok, index_live, _html} = live(conn, ~p"/tomatoes")

      assert index_live |> element("#tomatoes-#{tomato.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#tomatoes-#{tomato.id}")
    end
  end

  describe "Show" do
    setup [:create_tomato]

    test "displays tomato", %{conn: conn, tomato: tomato} do
      {:ok, _show_live, html} = live(conn, ~p"/tomatoes/#{tomato}")

      assert html =~ "Show Tomato"
    end

    test "updates tomato within modal", %{conn: conn, tomato: tomato} do
      {:ok, show_live, _html} = live(conn, ~p"/tomatoes/#{tomato}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Tomato"

      assert_patch(show_live, ~p"/tomatoes/#{tomato}/show/edit")

      assert show_live
             |> form("#tomato-form", tomato: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#tomato-form", tomato: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/tomatoes/#{tomato}")

      html = render(show_live)
      assert html =~ "Tomato updated successfully"
    end
  end
end
