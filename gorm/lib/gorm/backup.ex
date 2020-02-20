# defmodule Gorm.Database do
#   use GenServer
#   alias Gorm.Accounts
#   alias Gorm.Accounts.User
#   alias Gorm.Repo

#   def start_link(args) do
#     GenServer.start_link(__MODULE__, [])
#   end

#   def init(list) do
#     {:ok, []}
#   end

#   def list(pid) do
#     GenServer.call(pid, :list)
#   end

#   def handle_call(:list, _from, state) do
#     my_models = Accounts.list_users()

#     {:reply, my_models, state}
#   end
# end

# # alias Gorm.Database
# # Gorm.Database
# # iex(4)> Database.start_link([])
# # {:ok, #PID<0.457.0>}
# # iex(5)> {:ok, pid} = Database.start_link([])
# # {:ok, #PID<0.459.0>}
# # iex(6)> {:ok, pid} = Database.start_link([])
# # {:ok, #PID<0.461.0>}
# # iex(7)> pid
# # #PID<0.461.0>
# # iex(8)> Database.list(pid)
# # [debug] QUERY OK source="users" db=16.6ms decode=3.0ms queue=22.2ms idle=9049.3ms
# # SELECT u0."id", u0."email", u0."name", u0."inserted_at", u0."updated_at" FROM "users" AS u0 []
# # [
# #   %Gorm.Accounts.User{
# #     __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
# #     email: "ssaadamdkm@mfkmk.com",
# #     id: 1,
# #     inserted_at: ~N[2020-02-18 18:29:26],
# #     name: "siddhantsingh",
# #     updated_at: ~N[2020-02-18 18:29:26]
# #   }
# # ]
# # iex(9)>
