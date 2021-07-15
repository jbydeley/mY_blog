defmodule MyBlogWeb.PageLive do
  use MyBlogWeb, :live_view

  alias MyBlog.Room

  @impl true
  def mount(_params, _session, socket) do
    {:ok, restart(socket)}
  end

  @impl true
  def handle_event("start", _params, socket) do
    loop()
    {:noreply, assign(socket, started: true)}
  end

  @impl true
  def handle_event("restart", _params, socket) do
    {:noreply, restart(socket)}
  end

  @impl true
  def handle_event("stop", _params, socket) do
    {:noreply, assign(socket, started: false)}
  end

  @impl true
  def handle_info(:tick, %{assigns: %{ started: false }} = socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_info(:tick, socket) do
    %{loc: loc, size: size} = socket.assigns

    case Room.move(loc, size) do
      :done ->
        {:noreply, assign(socket, started: false)}
      {x, y, dir} ->
        loop()
        {:noreply, assign(socket, loc: {x, y, dir}, dir: dir)}
    end
  end

  defp loop() do
    Process.send_after(self(), :tick, 100)
  end

  defp restart(socket) do
    socket
    |> assign(size: 9, loc: {0, 0, :east}, dir: :east, bad: [], started: false)
  end

  defp draw(:north), do: "^"
  defp draw(:east), do: ">"
  defp draw(:south), do: "\\/"
  defp draw(:west), do: "<"
end
