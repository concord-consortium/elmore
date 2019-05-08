defmodule ElmoreWeb.LogApiController do
  use ElmoreWeb, :controller

  alias Elmore.LogManager

  def create(conn, log_params) do
    case LogManager.create_log_from_api(log_params) do
      {:ok, log} ->
        ElmoreWeb.Endpoint.broadcast("firehose:all", "log", log_params)
        # render(conn, "log.json", log_params)
        json(conn, %{status: "ok", log: log})

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect "ERROR"
        errors = ElmoreWeb.LogApiView.translate_errors(changeset)
        ElmoreWeb.Endpoint.broadcast("firehose:errors", "error", errors)
        conn
          |> put_status(500)
          |> render("error.json", changeset)
    end
  end
end
