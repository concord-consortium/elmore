defmodule Elmore.Repo.Migrations.CreateLogs do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :session, :string
      add :username, :string
      add :application, :string
      add :activity, :string
      add :event, :string
      add :time, :naive_datetime
      add :parameters, :string, default: "{}", null: false
      add :extras, :string, default: "{}", null: false
      add :event_value, :string
      add :run_remote_endpoint, :string

      timestamps()
    end

  end
end
