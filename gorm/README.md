# Gorm

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix


cd Gorm
mix Ecto.Create
mix Ecto.Migrate
iex -S mix phx.server


alias Gorm.Database
{:ok, pid} =  Database.start_link("redis://127.0.0.1:6379")
Database.check(pid)
Database.set(pid, "onetwo", "three")
Database.get(pid, "onetwo")
