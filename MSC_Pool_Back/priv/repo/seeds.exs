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
      password_hash: "some_hashed_pw"
    })
  end

  # Seed Teams
  defp seed_team(name, description) do
    Repo.insert!(%Team{
      name: name,
      description: description,
      user_id: 1
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
    for _ <- 1..count do
      Repo.insert!(%Clock{
        time: rand_datetime(7),
        status: Enum.random([true, false]),
        user_id: user_id
      })
    end
  end

  # Seed Schedules
  defp seed_schedules(user_id, count) do
    for _ <- 1..count do
      start_time = rand_datetime(30)
      end_time = DateTime.add(start_time, Enum.random(1..8) * 3_600, :second)
      Repo.insert!(%Schedule{
        start_time: start_time,
        end_time: end_time,
        user_id: user_id
      })
    end
  end

  def seed do
    # Creating users
    admin_user = seed_user("admin", "admin@example.com", "admin")

    # Creating teams
    dev_team = seed_team("Dev Team", "Development Team")

    # Creating memberships
    seed_membership(admin_user.id, dev_team.id)

    # Get all users
    users = Repo.all(User)

    # Seed Clocks and Schedules for all users
    Enum.each(users, fn user ->
      seed_clocks(user.id, 5) # Replace 5 with desired number of clocks per user
      seed_schedules(user.id, 5) # Replace 5 with desired number of schedules per user
    end)
  end
end

Seed.seed()
