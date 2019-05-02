defmodule ElmoreWeb.Router do
  use ElmoreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElmoreWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/logs", LogController
  end

  # Other scopes may use custom stacks.
  scope "/api", ElmoreWeb do
    pipe_through :api

    post "/logs", LogController, :create
  end
end
