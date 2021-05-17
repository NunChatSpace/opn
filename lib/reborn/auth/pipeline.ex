defmodule Reborn.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :reborn,
    module: Reborn.Auth.Guardian,
    error_handler: Guardian.Plug.ErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.LoadResource, allow_blank: true
end 