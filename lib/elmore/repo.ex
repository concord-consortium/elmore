defmodule Elmore.Repo do
  use Ecto.Repo,
    otp_app: :elmore,
    adapter: Ecto.Adapters.Postgres
end
