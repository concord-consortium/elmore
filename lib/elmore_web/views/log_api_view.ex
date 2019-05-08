defmodule ElmoreWeb.LogApiView do
  use ElmoreWeb, :view

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("log.json", conn) do
    IO.inspect conn["assigns"]
    # IO.inspect %{status: "ok", log: conn[:assigns]}
    %{status: "ok", log: conn[:assigns]}
  end

  def render("error.json", changeset) do
    %{status: "error", changeset: translate_errors(changeset)}
  end
end
