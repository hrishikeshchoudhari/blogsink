defmodule BlogsinkWeb.AppleLive.FormComponent do
  use BlogsinkWeb, :live_component

  alias Blogsink.Samples

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage apple records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="apple-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:origin]} type="text" label="Origin" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Apple</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{apple: apple} = assigns, socket) do
    changeset = Samples.change_apple(apple)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"apple" => apple_params}, socket) do
    changeset =
      socket.assigns.apple
      |> Samples.change_apple(apple_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"apple" => apple_params}, socket) do
    save_apple(socket, socket.assigns.action, apple_params)
  end

  defp save_apple(socket, :edit, apple_params) do
    case Samples.update_apple(socket.assigns.apple, apple_params) do
      {:ok, apple} ->
        notify_parent({:saved, apple})

        {:noreply,
         socket
         |> put_flash(:info, "Apple updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_apple(socket, :new, apple_params) do
    case Samples.create_apple(apple_params) do
      {:ok, apple} ->
        notify_parent({:saved, apple})

        {:noreply,
         socket
         |> put_flash(:info, "Apple created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
