defmodule MyIdea.Repo do
  use Ecto.Repo,
    otp_app: :my_idea,
    adapter: Ecto.Adapters.Postgres
end
