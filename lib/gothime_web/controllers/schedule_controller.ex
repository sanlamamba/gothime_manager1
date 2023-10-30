defmodule TimeManagerWeb.ScheduleController do
  use TimeManagerWeb, :controller

  alias TimeManager.Time
  alias TimeManager.Time.Schedule

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    schedules = Time.list_schedules()
    render(conn, :index, schedules: schedules)
  end

  def create(conn, %{"schedule" => schedule_params}) do
    with {:ok, %Schedule{} = schedule} <- Time.create_schedule(schedule_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/schedules/#{schedule}")
      |> render(:show, schedule: schedule)
    end
  end

  def show(conn, %{"id" => id}) do
    schedule = Time.get_schedule!(id)
    render(conn, :show, schedule: schedule)
  end

  def update(conn, %{"id" => id, "schedule" => schedule_params}) do
    schedule = Time.get_schedule!(id)

    with {:ok, %Schedule{} = schedule} <- Time.update_schedule(schedule, schedule_params) do
      render(conn, :show, schedule: schedule)
    end
  end

  def delete(conn, %{"id" => id}) do
    schedule = Time.get_schedule!(id)

    with {:ok, %Schedule{}} <- Time.delete_schedule(schedule) do
      send_resp(conn, :no_content, "")
    end
  end
end
