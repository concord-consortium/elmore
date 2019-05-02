defmodule ElmoreWeb.LogView do
  use ElmoreWeb, :view

  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("log.json", %{log: _log}) do
    %{status: "ok"}
  end

  def render("log.json", changeset) do
    %{status: "error", changeset: translate_errors(changeset)}
  end
end
