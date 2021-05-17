defmodule Reborn.Accounts.Session do

  alias Reborn.Accounts.User
  alias Reborn.Repo

  @spec authenticate(%{required(String.t()) => String.t(), required(String.t())=> String.t()}) :: boolean()
  def authenticate(%{"username" => username, "password" => given_password}) do
    user = Repo.get_by(User, username: username)
    check_password(user, given_password)
  end

  # In case no user was found before:
  @spec check_password(nil, String.t()) :: boolean()
  defp check_password(nil, _given_password) do
    {:error, "No user with this username was found!"}
  end

  # Use Comeonin to compare the passwords:
  @spec check_password(%{required(String.t())=> String.t()}, String.t()) :: boolean()
  defp check_password(%{encrypted_password: encrypted_password} = user, given_password) do
    case Bcrypt.verify_pass(given_password, encrypted_password) do
      true -> {:ok, user}
      _    -> {:error, "Incorrect password"}
    end
  end
end