defmodule BlogsinkWeb.AppleLive.Index do
  use BlogsinkWeb, :live_view

  alias Blogsink.Samples
  alias Blogsink.Samples.Apple

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :apples, Samples.list_apples())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Apple")
    |> assign(:apple, Samples.get_apple!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Apple")
    |> assign(:apple, %Apple{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Apples")
    |> assign(:apple, nil)
  end

  @impl true
  def handle_info({BlogsinkWeb.AppleLive.FormComponent, {:saved, apple}}, socket) do
    {:noreply, stream_insert(socket, :apples, apple)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    apple = Samples.get_apple!(id)
    {:ok, _} = Samples.delete_apple(apple)

    {:noreply, stream_delete(socket, :apples, apple)}
  end
end
