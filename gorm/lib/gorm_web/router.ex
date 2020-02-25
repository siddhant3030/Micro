defmodule GormWeb.Router do
  use GormWeb, :router

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

  pipeline :json_api do
    plug :accepts, ["json-api"]
    plug JaSerializer.Deserializer
  end


  scope "/", GormWeb do
    pipe_through :json_api

    get "/", PageController, :index
    resources "users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", GormWeb do
  #   pipe_through :api
  # end
end
