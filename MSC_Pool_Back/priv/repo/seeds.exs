alias TimeManagerModule.Repo
alias TimeManagerModule.Account.User
alias TimeManagerModule.Account.Team
alias TimeManagerModule.Account.Membership
alias TimeManagerModule.Time.Clock
alias TimeManagerModule.Time.Schedule

defmodule Seed do
  # Helper function to create a random datetime within the past `days`
  defp rand_datetime(days_past) do
    DateTime.utc_now()
    |> DateTime.add(-Enum.random(0..days_past) * 86_400, :second)
    |> DateTime.truncate(:second)
  end

  # Seed Users
  defp seed_user(username, email, role) do
    Repo.insert!(%User{
      username: username,
      email: email,
      is_visible: true,
      role: role,
      password_hash: Bcrypt.hash_pwd_salt("pass1234")
    })
  end

  # Seed Teams
  defp seed_team(name, description, manager_id) do
    Repo.insert!(%Team{
      name: name,
      description: description,
      user_id: manager_id
    })
  end

  # Seed Memberships
  defp seed_membership(user_id, team_id) do
    Repo.insert!(%Membership{
      user_id: user_id,
      team_id: team_id
    })
  end

  # Seed Clocks
  defp seed_clocks(user_id, count) do
    Enum.each(1..count, fn _ ->
      time = rand_datetime(7)
      Repo.insert!(%Clock{time: time, status: true, user_id: user_id})
      # Ensuring clock out is after clock in
      clock_out_time = DateTime.add(time, Enum.random(300..3600), :second)
      Repo.insert!(%Clock{time: clock_out_time, status: false, user_id: user_id})
    end)
  end

  # Seed Schedules
  # Seed Schedules
defp seed_schedules(user_id, count) do
  Enum.each(1..count, fn _ ->
    start_time = rand_datetime(30)
    end_time = DateTime.add(start_time, Enum.random(1..8) * 3_600, :second)

    # Check if end_time is on the same day as start_time; if not, set to end of start_time's day
    end_of_day_time = %DateTime{
      year: start_time.year,
      month: start_time.month,
      day: start_time.day,
      hour: 23,
      minute: 59,
      second: 59,
      time_zone: start_time.time_zone,
      zone_abbr: start_time.zone_abbr,
      utc_offset: start_time.utc_offset,
      std_offset: start_time.std_offset,
    }

    end_time = if DateTime.to_date(start_time) == DateTime.to_date(end_time), do: end_time, else: end_of_day_time

    Repo.insert!(%Schedule{
      start_time: start_time,
      end_time: end_time,
      user_id: user_id
    })
  end)
end


  def seed do
    # Create an admin and smanager user
    admin_user = seed_user("admin", "admin@example.com", "admin")
    smanager_user = seed_user("smanager", "smanager@example.com", "smanager")

    # Create 10 users with role 'manager'
    managers = Enum.map(1..10, fn i ->
      seed_user("manager#{i}", "manager#{i}@example.com", "manager")
    end)

    # Create 10 teams with a manager from the managers list
    teams = Enum.map(1..10, fn i ->
      seed_team("Team #{i}", "Description for Team #{i}", Enum.at(managers, i - 1).id)
    end)

    # Creating 30 memberships randomly assigning users to teams
    Enum.each(1..30, fn _ ->
      user = Enum.random(managers)
      team = Enum.random(teams)
      seed_membership(user.id, team.id)
    end)

    # Create additional users with role 'user' and associate with teams
    additional_users = Enum.map(11..30, fn i ->
      seed_user("user#{i}", "user#{i}@example.com", "user")
    end)

    # Creating 100 schedules randomly among all users
    all_users = managers ++ additional_users
    Enum.each(all_users, fn user ->
      seed_schedules(user.id, 10) # Each user gets 10 schedules
    end)

    # Creating 300 clocks ensuring there is a clock out for every clock in
    Enum.each(all_users, fn user ->
      seed_clocks(user.id, 15) # Each user gets 15 pairs of clocks (30 total clocks)
    end)
  end
end

Seed.seed()
