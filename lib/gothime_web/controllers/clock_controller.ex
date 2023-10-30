defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller

  alias TimeManager.Time
  alias TimeManager.Time.Clock

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    clocks = Time.list_clocks()
    render(conn, :index, clocks: clocks)
  end

  def create(conn, %{"clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- Time.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/clocks/#{clock}")
      |> render(:show, clock: clock)
    end
  end

  def show(conn, %{"id" => id}) do
    clock = Time.get_clock!(id)
    render(conn, :show, clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Time.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Time.update_clock(clock, clock_params) do
      render(conn, :show, clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Time.get_clock!(id)

    with {:ok, %Clock{}} <- Time.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end

  def createwithuser(conn, %{"clock" => clock_params, "user_id" => user_id}) do
    with {:ok, %Clock{} = clock} <- Time.create_clock(Map.put(clock_params, "user_id", user_id)) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/clocks/#{clock.id}")
      |> render(:show, clock: clock)
    end
  end



  def get_clocks_by_userid(conn, %{"user_id" => user_id}) do
    case Time.get_clocks_by_userid(user_id) do
      {:ok, clocks} ->
        # nous réutilisons la vue `index`
        render(conn, :index, clocks: clocks)

      {:error, reason} ->
        json(conn, %{error: reason})
    end
  end
end
