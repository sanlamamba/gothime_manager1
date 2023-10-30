defmodule TimeManager.TimeTest do
  use TimeManager.DataCase

  alias TimeManager.Time

  describe "clocks" do
    alias TimeManager.Time.Clock

    import TimeManager.TimeFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Time.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Time.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~N[2023-10-29 13:31:00]}

      assert {:ok, %Clock{} = clock} = Time.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~N[2023-10-29 13:31:00]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Time.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~N[2023-10-30 13:31:00]}

      assert {:ok, %Clock{} = clock} = Time.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~N[2023-10-30 13:31:00]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Time.update_clock(clock, @invalid_attrs)
      assert clock == Time.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Time.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Time.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Time.change_clock(clock)
    end
  end

  describe "schedules" do
    alias TimeManager.Time.Schedule

    import TimeManager.TimeFixtures

    @invalid_attrs %{start_time: nil, end_time: nil}

    test "list_schedules/0 returns all schedules" do
      schedule = schedule_fixture()
      assert Time.list_schedules() == [schedule]
    end

    test "get_schedule!/1 returns the schedule with given id" do
      schedule = schedule_fixture()
      assert Time.get_schedule!(schedule.id) == schedule
    end

    test "create_schedule/1 with valid data creates a schedule" do
      valid_attrs = %{start_time: ~N[2023-10-29 13:32:00], end_time: ~N[2023-10-29 13:32:00]}

      assert {:ok, %Schedule{} = schedule} = Time.create_schedule(valid_attrs)
      assert schedule.start_time == ~N[2023-10-29 13:32:00]
      assert schedule.end_time == ~N[2023-10-29 13:32:00]
    end

    test "create_schedule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Time.create_schedule(@invalid_attrs)
    end

    test "update_schedule/2 with valid data updates the schedule" do
      schedule = schedule_fixture()
      update_attrs = %{start_time: ~N[2023-10-30 13:32:00], end_time: ~N[2023-10-30 13:32:00]}

      assert {:ok, %Schedule{} = schedule} = Time.update_schedule(schedule, update_attrs)
      assert schedule.start_time == ~N[2023-10-30 13:32:00]
      assert schedule.end_time == ~N[2023-10-30 13:32:00]
    end

    test "update_schedule/2 with invalid data returns error changeset" do
      schedule = schedule_fixture()
      assert {:error, %Ecto.Changeset{}} = Time.update_schedule(schedule, @invalid_attrs)
      assert schedule == Time.get_schedule!(schedule.id)
    end

    test "delete_schedule/1 deletes the schedule" do
      schedule = schedule_fixture()
      assert {:ok, %Schedule{}} = Time.delete_schedule(schedule)
      assert_raise Ecto.NoResultsError, fn -> Time.get_schedule!(schedule.id) end
    end

    test "change_schedule/1 returns a schedule changeset" do
      schedule = schedule_fixture()
      assert %Ecto.Changeset{} = Time.change_schedule(schedule)
    end
  end
end
