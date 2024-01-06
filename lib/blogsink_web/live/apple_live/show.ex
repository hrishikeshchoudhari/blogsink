defmodule BlogsinkWeb.AppleLive.Show do
  use BlogsinkWeb, :live_view

  alias Blogsink.Samples

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:apple, Samples.get_apple!(id))}
  end

  defp page_title(:show), do: "Show Apple"
  defp page_title(:edit), do: "Edit Apple"
end
