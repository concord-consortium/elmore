defmodule Elmore.LogManager.Log do
  use Ecto.Schema
  import Ecto.Changeset

  schema "logs" do
    field :activity, :string
    field :application, :string
    field :event, :string
    field :event_value, :string
    field :extras, :string
    field :parameters, :string
    field :run_remote_endpoint, :string
    field :session, :string
    field :time, :naive_datetime
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:session, :username, :application, :activity, :event, :time, :parameters, :extras, :event_value, :run_remote_endpoint])
    |> validate_required([:session, :username, :application, :activity, :event, :time, :parameters, :extras, :event_value, :run_remote_endpoint])
  end
end
