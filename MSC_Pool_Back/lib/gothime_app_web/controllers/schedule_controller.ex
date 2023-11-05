defmodule TimeManagerModuleWeb.ScheduleController do
  use TimeManagerModuleWeb, :controller

  alias TimeManagerModule.Time
  alias TimeManagerModule.Time.Schedule

  action_fallback(TimeManagerModuleWeb.FallbackController)

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

  # CUSTOM
  def get_schedules_by_user_and_date_range(
        conn,
        %{"user_id" => user_id, "start_time" => start_time, "end_time" => end_time}
      ) do
    case Time.get_schedules_by_user_and_date_range(user_id, start_time, end_time) do
      {:ok, schedules} ->
        # nous réutilisons la vue `index`
        render(conn, :index, schedules: schedules)

      {:error, reason} ->
        json(conn, %{error: reason})
    end
  end

  def get_schedule_by_userid_and_id(conn, %{"user_id" => user_id, "id" => id}) do
    case Time.get_schedule_by_userid_and_id(user_id, id) do
      {:ok, schedules} ->
        # nous réutilisons la vue `index`
        render(conn, :index, schedules: schedules)

      {:error, reason} ->
        json(conn, %{error: reason})
    end
  end
end
