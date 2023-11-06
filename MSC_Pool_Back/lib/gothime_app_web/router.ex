defmodule TimeManagerModuleWeb.Router do
  use TimeManagerModuleWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: [~r/^https?:\/\/localhost:3000\/.*$/]
  end

  scope "/api", TimeManagerModuleWeb do
    pipe_through :api

    get("/usersBy", UserController, :showByEmailAndUsername)
    get("/users/all", UserController, :index)
    resources("/users", UserController, except: [:new])

    resources("/teams/", TeamController)

    get("/memberships/:userID", MembershipController, :get_memberships_by_user)
    get("/memberships/team/:teamID", MembershipController, :get_memberships_by_team)
    resources("/memberships", MembershipController)

    post("/clocks/:user_id", ClockController, :create_with_user)
    get("/clocks", ClockController, :get_clocks_by_userid)


    get("/schedules/:user_id", ScheduleController, :get_schedules_by_user_and_date_range)
    get("/schedules/:user_id/:id", ScheduleController, :get_schedule_by_userid_and_id)
    post("schedules/", ScheduleController, :create )
    resources("/schedules/", ScheduleController, except: [:new, :edit])

  end
end
