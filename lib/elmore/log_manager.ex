defmodule Elmore.LogManager do
  @moduledoc """
  The LogManager context.
  """

  import Ecto.Query, warn: false
  alias Elmore.Repo

  alias Elmore.LogManager.Log

  @doc """
  Returns the list of logs.

  ## Examples

      iex> list_logs()
      [%Log{}, ...]

  """
  def list_logs do
    Repo.all(Log)
  end

  @doc """
  Gets a single log.

  Raises `Ecto.NoResultsError` if the Log does not exist.

  ## Examples

      iex> get_log!(123)
      %Log{}

      iex> get_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_log!(id), do: Repo.get!(Log, id)

  @doc """
  Creates a log.

  ## Examples

      iex> create_log(%{field: value})
      {:ok, %Log{}}

      iex> create_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_log(attrs \\ %{}) do
    %Log{}
    |> Log.changeset(attrs)
    |> Repo.insert()
  end

  defp event_value(%{"event_value" => val}) when is_integer(val), do: Integer.to_string(val)
  defp event_value(%{"event_value" => val}), do: val

  def create_log_from_api(attrs \\ %{}) do
    default_log = %{
      "session"=> "",
      "application"=> "",
      "activity"=> "",
      "event"=> "",
      "time"=> 0,
      "event_value"=> ""
    }
    {defined_log, extras} = default_log
     |> Map.merge(attrs)
     |> Map.split(Map.keys(default_log))
    {:ok, time} = DateTime.from_unix(defined_log["time"], :millisecond)
    defined_attrs = defined_log
      |> Map.put("event_value", event_value(defined_log))
      |> Map.put("extras", Jason.encode!(extras))
      |> Map.put("time", time)
    %Log{}
      |> Log.changeset(defined_attrs)
      |> Repo.insert()
  end

  @doc """
  Updates a log.

  ## Examples

      iex> update_log(log, %{field: new_value})
      {:ok, %Log{}}

      iex> update_log(log, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_log(%Log{} = log, attrs) do
    log
    |> Log.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Log.

  ## Examples

      iex> delete_log(log)
      {:ok, %Log{}}

      iex> delete_log(log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_log(%Log{} = log) do
    Repo.delete(log)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking log changes.

  ## Examples

      iex> change_log(log)
      %Ecto.Changeset{source: %Log{}}

  """
  def change_log(%Log{} = log) do
    Log.changeset(log, %{})
  end
end
