defmodule Reborn.Accounts do
    import Ecto.Changeset
    alias Reborn.Accounts.User
    alias Reborn.Repo

    # For testing "create_user"
    # 1.  iex -S mix
    # 2.  params = %{username: "nun", email: "nun@test.com", encrypted_password: "a3w2d1a4fawf54"}
    # 3.  Reborn.Accounts.create_user(params)

    # Pattern match to extract the password 
    # And apply it in    Comeonin.Bcrypt.hashpwsalt(password)
    @spec create_user(%User{}) :: %User{}
    def create_user(%{"password" => password} = params) do
        # Encrypt the password with Comeonin:
        encrypted_password = Bcrypt.hash_pwd_salt(password)
        IO.puts "Password: #{encrypted_password}"
        params = Map.put(params, "encrypted_password", encrypted_password)
        register_changeset(params)
        |> put_change(:encrypted_password, encrypted_password)
        # Insert to database 
        # must add "alias Reborn.Repo" before
        |> Repo.insert
    end

    @spec register_changeset(%User{}) :: %User{}
    def register_changeset(params \\ %{}) do 
        # Create a user struct
        # must add "alias Reborn.User" before
        %User{}
        # Check params contains following keys
        |> cast(params, [:username, :email, :encrypted_password])
        # Require 3 field, username, email, encrpyed_password must not null
        |> validate_required([:username, :email, :encrypted_password])
        |> unique_constraint(:email)
        |> unique_constraint(:username)
        |> validate_format(:email, ~r/@/)
        |> validate_format(:username, ~r/^[a-zA-Z0-9]*$/)
        |> validate_length(:password, min: 4)
    end

    @spec get_user_changeset() :: %User{}
    def get_user_changeset() do
        change_set = User.changeset(%User{})
        change_set
    end

end
