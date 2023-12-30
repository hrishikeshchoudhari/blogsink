defmodule Blogsink.Repo do
  use Ecto.Repo,
    otp_app: :blogsink,
    adapter: Ecto.Adapters.Postgres
end
