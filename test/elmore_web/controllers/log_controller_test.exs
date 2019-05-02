defmodule ElmoreWeb.LogControllerTest do
  use ElmoreWeb.ConnCase

  alias Elmore.LogManager

  @create_attrs %{activity: "some activity", application: "some application", event: "some event", event_value: "some event_value", extras: "some extras", parameters: "some parameters", run_remote_endpoint: "some run_remote_endpoint", session: "some session", time: ~N[2010-04-17 14:00:00], username: "some username"}
  @update_attrs %{activity: "some updated activity", application: "some updated application", event: "some updated event", event_value: "some updated event_value", extras: "some updated extras", parameters: "some updated parameters", run_remote_endpoint: "some updated run_remote_endpoint", session: "some updated session", time: ~N[2011-05-18 15:01:01], username: "some updated username"}
  @invalid_attrs %{activity: nil, application: nil, event: nil, event_value: nil, extras: nil, parameters: nil, run_remote_endpoint: nil, session: nil, time: nil, username: nil}

  def fixture(:log) do
    {:ok, log} = LogManager.create_log(@create_attrs)
    log
  end

  describe "index" do
    test "lists all logs", %{conn: conn} do
      conn = get(conn, Routes.log_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Logs"
    end
  end

  describe "new log" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.log_path(conn, :new))
      assert html_response(conn, 200) =~ "New Log"
    end
  end

  describe "create log" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.log_path(conn, :create), log: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.log_path(conn, :show, id)

      conn = get(conn, Routes.log_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Log"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.log_path(conn, :create), log: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Log"
    end
  end

  describe "edit log" do
    setup [:create_log]

    test "renders form for editing chosen log", %{conn: conn, log: log} do
      conn = get(conn, Routes.log_path(conn, :edit, log))
      assert html_response(conn, 200) =~ "Edit Log"
    end
  end

  describe "update log" do
    setup [:create_log]

    test "redirects when data is valid", %{conn: conn, log: log} do
      conn = put(conn, Routes.log_path(conn, :update, log), log: @update_attrs)
      assert redirected_to(conn) == Routes.log_path(conn, :show, log)

      conn = get(conn, Routes.log_path(conn, :show, log))
      assert html_response(conn, 200) =~ "some updated activity"
    end

    test "renders errors when data is invalid", %{conn: conn, log: log} do
      conn = put(conn, Routes.log_path(conn, :update, log), log: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Log"
    end
  end

  describe "delete log" do
    setup [:create_log]

    test "deletes chosen log", %{conn: conn, log: log} do
      conn = delete(conn, Routes.log_path(conn, :delete, log))
      assert redirected_to(conn) == Routes.log_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.log_path(conn, :show, log))
      end
    end
  end

  defp create_log(_) do
    log = fixture(:log)
    {:ok, log: log}
  end
end
