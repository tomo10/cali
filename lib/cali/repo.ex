defmodule Cali.Repo do
  use Ecto.Repo,
    otp_app: :cali,
    adapter: Ecto.Adapters.Postgres
end
