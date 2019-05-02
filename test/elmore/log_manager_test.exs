defmodule Elmore.LogManagerTest do
  use Elmore.DataCase

  alias Elmore.LogManager

  describe "logs" do
    alias Elmore.LogManager.Log

    @valid_attrs %{activity: "some activity", application: "some application", event: "some event", event_value: "some event_value", extras: "some extras", parameters: "some parameters", run_remote_endpoint: "some run_remote_endpoint", session: "some session", time: ~N[2010-04-17 14:00:00], username: "some username"}
    @update_attrs %{activity: "some updated activity", application: "some updated application", event: "some updated event", event_value: "some updated event_value", extras: "some updated extras", parameters: "some updated parameters", run_remote_endpoint: "some updated run_remote_endpoint", session: "some updated session", time: ~N[2011-05-18 15:01:01], username: "some updated username"}
    @invalid_attrs %{activity: nil, application: nil, event: nil, event_value: nil, extras: nil, parameters: nil, run_remote_endpoint: nil, session: nil, time: nil, username: nil}

    def log_fixture(attrs \\ %{}) do
      {:ok, log} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LogManager.create_log()

      log
    end

    test "list_logs/0 returns all logs" do
      log = log_fixture()
      assert LogManager.list_logs() == [log]
    end

    test "get_log!/1 returns the log with given id" do
      log = log_fixture()
      assert LogManager.get_log!(log.id) == log
    end

    test "create_log/1 with valid data creates a log" do
      assert {:ok, %Log{} = log} = LogManager.create_log(@valid_attrs)
      assert log.activity == "some activity"
      assert log.application == "some application"
      assert log.event == "some event"
      assert log.event_value == "some event_value"
      assert log.extras == "some extras"
      assert log.parameters == "some parameters"
      assert log.run_remote_endpoint == "some run_remote_endpoint"
      assert log.session == "some session"
      assert log.time == ~N[2010-04-17 14:00:00]
      assert log.username == "some username"
    end

    test "create_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LogManager.create_log(@invalid_attrs)
    end

    test "update_log/2 with valid data updates the log" do
      log = log_fixture()
      assert {:ok, %Log{} = log} = LogManager.update_log(log, @update_attrs)
      assert log.activity == "some updated activity"
      assert log.application == "some updated application"
      assert log.event == "some updated event"
      assert log.event_value == "some updated event_value"
      assert log.extras == "some updated extras"
      assert log.parameters == "some updated parameters"
      assert log.run_remote_endpoint == "some updated run_remote_endpoint"
      assert log.session == "some updated session"
      assert log.time == ~N[2011-05-18 15:01:01]
      assert log.username == "some updated username"
    end

    test "update_log/2 with invalid data returns error changeset" do
      log = log_fixture()
      assert {:error, %Ecto.Changeset{}} = LogManager.update_log(log, @invalid_attrs)
      assert log == LogManager.get_log!(log.id)
    end

    test "delete_log/1 deletes the log" do
      log = log_fixture()
      assert {:ok, %Log{}} = LogManager.delete_log(log)
      assert_raise Ecto.NoResultsError, fn -> LogManager.get_log!(log.id) end
    end

    test "change_log/1 returns a log changeset" do
      log = log_fixture()
      assert %Ecto.Changeset{} = LogManager.change_log(log)
    end
  end
end
