defmodule TimeManagerModule.TimeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManagerModule.Time` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~U[2023-11-04 20:14:00Z]
      })
      |> TimeManagerModule.Time.create_clock()

    clock
  end

  @doc """
  Generate a schedule.
  """
  def schedule_fixture(attrs \\ %{}) do
    {:ok, schedule} =
      attrs
      |> Enum.into(%{
        end_time: ~U[2023-11-04 20:14:00Z],
        start_time: ~U[2023-11-04 20:14:00Z]
      })
      |> TimeManagerModule.Time.create_schedule()

    schedule
  end
end
