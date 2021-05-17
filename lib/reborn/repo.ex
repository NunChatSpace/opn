defmodule Reborn.Repo do
  use Ecto.Repo,
    otp_app: :reborn,
    adapter: Ecto.Adapters.MyXQL
end
