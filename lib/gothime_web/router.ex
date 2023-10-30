defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TimeManagerWeb do
    pipe_through :api

    get "/users", UserController, :showByEmailAndUsername
    resources "/users", UserController, except: [:new]

    resources "/teams/", TeamController


  end
end
