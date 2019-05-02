defmodule ElmoreWeb.LogController do
  use ElmoreWeb, :controller

  alias Elmore.LogManager
  alias Elmore.LogManager.Log

  def index(conn, _params) do
    logs = LogManager.list_logs()
    render(conn, "index.html", logs: logs)
  end

  def new(conn, _params) do
    changeset = LogManager.change_log(%Log{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(%{private: %{phoenix_format: "json"}} = conn, %{"log" => log_params}) do
    IO.inspect(conn)
    case LogManager.create_log(log_params) do
      {:ok, log} ->
        render(conn, "log.json", log)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "log.json", changeset)
    end
  end

  def create(conn, %{"log" => log_params}) do
    case LogManager.create_log(log_params) do
      {:ok, log} ->
        conn
        |> put_flash(:info, "Log created successfully.")
        |> redirect(to: Routes.log_path(conn, :show, log))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    log = LogManager.get_log!(id)
    render(conn, "show.html", log: log)
  end

  def edit(conn, %{"id" => id}) do
    log = LogManager.get_log!(id)
    changeset = LogManager.change_log(log)
    render(conn, "edit.html", log: log, changeset: changeset)
  end

  def update(conn, %{"id" => id, "log" => log_params}) do
    log = LogManager.get_log!(id)

    case LogManager.update_log(log, log_params) do
      {:ok, log} ->
        conn
        |> put_flash(:info, "Log updated successfully.")
        |> redirect(to: Routes.log_path(conn, :show, log))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", log: log, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    log = LogManager.get_log!(id)
    {:ok, _log} = LogManager.delete_log(log)

    conn
    |> put_flash(:info, "Log deleted successfully.")
    |> redirect(to: Routes.log_path(conn, :index))
  end
end
