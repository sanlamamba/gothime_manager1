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

    post "/clockswithuser", ClockController, :createwithuser
    get "/clocks", ClockController, :get_clocks_by_userid
    # resources "/clocks/", ClockController, except: [:new, :edit]


  end
end
