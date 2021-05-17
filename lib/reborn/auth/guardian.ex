defmodule Reborn.Auth.Guardian do
    use Guardian, otp_app: :reborn

  alias Reborn.Repo
  alias Reborn.Accounts.User

  def subject_for_token(user = %User{}, _claims) do
    { :ok, to_string(user.id) }
  end

  def subject_for_token(_, _) do
    { :error, "Unknown resource type" }
  end

  def resource_from_claims(claims) do
    { :ok, Repo.get(User, claims["sub"]) }
  end

end