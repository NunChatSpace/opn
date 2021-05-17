defmodule RebornWeb.Router do
  use RebornWeb, :router
  import Plug.BasicAuth
  alias Reborn.GatewayPlug
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Reborn.Auth.Pipeline
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RebornWeb do
    pipe_through [:browser, :browser_session]

    get "/", PageController, :index
    get "/login", PageController, :login
    get "/signup", PageController, :signup
    get "/logout", PageController, :logout

    post "/signup", PageController, :create_user
    post "/login", PageController, :login_user
    
  end

  pipeline :admins_only do
    plug :basic_auth, username: "admin", password: "admins"
  end

  pipeline :gateway do
    plug GatewayPlug
  end

  scope "/" do
    pipe_through [:browser, :admins_only, :gateway]
    live_dashboard "/dashboard", metrics: RebornWeb.Telemetry
  end
end
