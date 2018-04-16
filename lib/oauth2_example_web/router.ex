defmodule Oauth2ExampleWeb.Router do
  use Oauth2ExampleWeb, :router

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

  scope "/", Oauth2ExampleWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
  end

  scope "/auth", Oauth2ExampleWeb do
    pipe_through :browser

    # When a URL of any provider comes direct it to AuthController
    get "/:provider", AuthController, :request
    # to handle all the callback requests
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", Oauth2ExampleWeb do
  #   pipe_through :api
  # end
end
