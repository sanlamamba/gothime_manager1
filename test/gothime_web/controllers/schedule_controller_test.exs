defmodule TimeManagerWeb.ScheduleControllerTest do
  use TimeManagerWeb.ConnCase

  import TimeManager.TimeFixtures

  alias TimeManager.Time.Schedule

  @create_attrs %{
    start_time: ~N[2023-10-29 13:32:00],
    end_time: ~N[2023-10-29 13:32:00]
  }
  @update_attrs %{
    start_time: ~N[2023-10-30 13:32:00],
    end_time: ~N[2023-10-30 13:32:00]
  }
  @invalid_attrs %{start_time: nil, end_time: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all schedules", %{conn: conn} do
      conn = get(conn, ~p"/api/schedules")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create schedule" do
    test "renders schedule when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/schedules", schedule: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/schedules/#{id}")

      assert %{
               "id" => ^id,
               "end_time" => "2023-10-29T13:32:00",
               "start_time" => "2023-10-29T13:32:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/schedules", schedule: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update schedule" do
    setup [:create_schedule]

    test "renders schedule when data is valid", %{conn: conn, schedule: %Schedule{id: id} = schedule} do
      conn = put(conn, ~p"/api/schedules/#{schedule}", schedule: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/schedules/#{id}")

      assert %{
               "id" => ^id,
               "end_time" => "2023-10-30T13:32:00",
               "start_time" => "2023-10-30T13:32:00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, schedule: schedule} do
      conn = put(conn, ~p"/api/schedules/#{schedule}", schedule: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete schedule" do
    setup [:create_schedule]

    test "deletes chosen schedule", %{conn: conn, schedule: schedule} do
      conn = delete(conn, ~p"/api/schedules/#{schedule}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/schedules/#{schedule}")
      end
    end
  end

  defp create_schedule(_) do
    schedule = schedule_fixture()
    %{schedule: schedule}
  end
end
