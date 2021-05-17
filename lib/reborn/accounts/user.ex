# Before create this file run below command to generate schema
# mix phx.gen.schema User users username:string email:string encrypted_password:string
# then mix ecto.migrate

defmodule Reborn.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :username, :string
    field :password, :string, virtual: true
    
    timestamps()
  end

  # def changeset(user, attrs \\ %{}) do
  #   user
  #   |> cast(attrs, [:username, :email, :encrypted_password])
  #   |> validate_required([:username, :email, :encrypted_password])
  # end
end
