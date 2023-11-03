defmodule TimeManager.Seeds do
  alias TimeManager.Accounts.Team
  alias TimeManager.Accounts.User
  alias TimeManager.Time.Clock
  alias TimeManager.Time.Schedule
  alias TimeManager.Repo

  team_count = 9
  user_count = 99
  clock_count = 999
  schedule_count = 499

  # def create_seeds do
  for i <- 0..team_count do
    %Team{
      name: "Team #{i}",
      description: "Team #{i} description"
    }
    |> Repo.insert!()
  end

  for i <- 0..user_count do
    %User{
      username: "User #{i}",
      email: "user#{i}@example.com",
      is_visible: true,
      team_id: Enum.random(1..team_count)
    }
    |> Repo.insert!()
  end

  for _ <- 0..schedule_count do
    # Generate a random start_time within the last 30 days
    days_ago = :rand.uniform(30) - 1
    start_time = DateTime.add(DateTime.utc_now(), -days_ago * 86400)

    # Calculate an end_time that's between 1 to 8 hours after the start_time
    hours = :rand.uniform(8)
    end_time = DateTime.add(start_time, hours * 3600)

    # Convert DateTime to NaiveDateTime and truncate microseconds
    start_time_naive = DateTime.to_naive(start_time) |> NaiveDateTime.truncate(:second)
    end_time_naive = DateTime.to_naive(end_time) |> NaiveDateTime.truncate(:second)

    %Schedule{
      start_time: start_time_naive,
      end_time: end_time_naive,
      user_id: Enum.random(1..user_count)
    }
    |> Repo.insert!()
  end

  for _ <- 1..clock_count do
    # Generate a random time within the last 7 days
    days_ago = :rand.uniform(7) - 1
    random_time = DateTime.add(DateTime.utc_now(), -days_ago * 86400)

    # Convert DateTime to NaiveDateTime and truncate microseconds
    random_time_naive = DateTime.to_naive(random_time) |> NaiveDateTime.truncate(:second)

    # Generate a random status (true or false)
    status = :rand.uniform(2) == 1

    %Clock{
      time: random_time_naive,
      status: status,
      user_id: Enum.random(1..user_count)
    }
    |> Repo.insert!()
  end

end
