defmodule ElmoreWeb.FirehoseChannel do
  use Phoenix.Channel

  def join("firehose:all", _message, socket) do
    {:ok, socket}
  end

  # def handle_in("log", params, socket) do
  #   broadcast! socket, "log", params
  #   {:noreply, socket}
  # end

  # def handle_in("error", params, socket) do
  #   broadcast! socket, "log", params
  #   {:noreply, socket}
  # end
end
