defmodule ElmoreWeb.PageController do
  use ElmoreWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
