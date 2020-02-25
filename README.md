# KubernetesApi

Learning GO

cd Gorm
mix Ecto.Create
mix Ecto.Migrate
iex -S mix phx.server


alias Gorm.Database
{:ok, pid} =  Database.start_link("redis://127.0.0.1:6379")
Database.check(pid)
Database.set(pid, "onetwo", "three")
Database.get(pid, "onetwo")
