defmodule TimeManager.TimeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Time` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2023-10-29 13:31:00]
      })
      |> TimeManager.Time.create_clock()

    clock
  end

  @doc """
  Generate a schedule.
  """
  def schedule_fixture(attrs \\ %{}) do
    {:ok, schedule} =
      attrs
      |> Enum.into(%{
        end_time: ~N[2023-10-29 13:32:00],
        start_time: ~N[2023-10-29 13:32:00]
      })
      |> TimeManager.Time.create_schedule()

    schedule
  end
end
