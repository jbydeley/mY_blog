defmodule MyBlogWeb.PageLive do
  use MyBlogWeb, :live_view

  alias MyBlog.Room

  @impl true
  def mount(_params, _session, socket) do
    {:ok, restart(socket)}
  end

  @impl true
  def handle_event("toggle", _params, socket) do
    loop()
    {:noreply, assign(socket, started: !socket.assigns.started)}
  end

  @impl true
  def handle_event("restart", _params, socket) do
    {:noreply, restart(socket)}
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
        socket = push_event(socket, "move", %{x: x, y: y, dir: to_string(dir)})
        {:noreply, assign(socket, loc: {x, y, dir}, dir: dir)}
    end
  end

  defp loop() do
    Process.send_after(self(), :tick, 100)
  end

  defp restart(socket) do
    socket
    |> push_event("move", %{x: 0, y: 0, dir: "east"})
    |> assign(size: 9, loc: {0, 0, :east}, dir: :east, bad: [], started: false)
  end

  defp in_progress({x, y, _dir}) when x > 0 or y > 0, do: true
  defp in_progress(_), do: false

  defp cell_name({x, y}), do: "cell-#{x}-#{y}"
end
