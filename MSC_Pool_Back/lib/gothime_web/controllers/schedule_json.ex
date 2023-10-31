defmodule TimeManagerWeb.ScheduleJSON do
  alias TimeManager.Time.Schedule

  @doc """
  Renders a list of schedules.
  """
  def index(%{schedules: schedules}) do
    %{data: for(schedule <- schedules, do: data(schedule))}
  end

  @doc """
  Renders a single schedule.
  """
  def show(%{schedule: schedule}) do
    %{data: data(schedule)}
  end

  defp data(%Schedule{} = schedule) do
    %{
      id: schedule.id,
      start_time: schedule.start_time,
      end_time: schedule.end_time
    }
  end
end
