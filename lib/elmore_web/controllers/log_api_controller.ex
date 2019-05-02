defmodule ElmoreWeb.LogApiController do
  use ElmoreWeb, :controller

  alias Elmore.LogManager

  def create(conn, log_params) do
    case LogManager.create_log(log_params) do
      {:ok, log} ->
        # ElmoreWeb.Endpoint.broadcast("firehose:all", "log", log_params)
        render(conn, "log.json", log)

      {:error, %Ecto.Changeset{} = changeset} ->
        errors = ElmoreWeb.LogApiView.translate_errors(changeset)
        ElmoreWeb.Endpoint.broadcast("firehose:errors", "error", errors)
        render(conn, "log.json", changeset)
    end
  end
end
