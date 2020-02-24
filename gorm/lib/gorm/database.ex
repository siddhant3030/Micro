defmodule Gorm.Database do
  use GenServer
  require Logger
  alias Gorm.Accounts

  # "redis://localhost:6379/3"

  #connect the redis server
  def start_link(url) do
    GenServer.start_link(__MODULE__, {url})
  end

  def init({url}) do
    Logger.info("connect to url #{url}");
    case Redix.start_link(url) do
      {:ok, conn} -> {:ok, conn}
      {:error, err} -> {:error, err}
    end
  end

  # checking the connection if it's connected to redis or not
  def check(pid) do
    GenServer.call(pid, :check)
  end

  # handle call for check function
  def handle_call(:check, _from, state) do
    checking = Redix.command!(state, ["PING"])
    {:reply, checking, state}
  end

  # get the key function
  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  # handle call for get function
  def handle_call({:get, key}, _from, state) do
    reply = Redix.command(state, ["GET", key])
    {:reply, {:ok, reply}, state}
  end

  # set the key function
  def set(pid, key, value) do
    GenServer.call(pid, {:set, key, value})
  end

  # handle call for set function
  def handle_call({:set, key, value}, _from, state) do
    reply = Redix.command(state, ["SET", key, value])
    {:reply, {:ok, reply}, state}
  end

  # Get the single user from the database
  def userone(pid, id) do
    GenServer.call(pid, {:userone, id})
  end

  # Get the list of user from the database
  def list(pid) do
    GenServer.call(pid, :list)
  end

  # handle call for the list function
  def handle_call(:list, _from, state) do
    my_models = Accounts.list_users()

    {:reply, my_models, state}
  end

  # handle call for the single user function
  def handle_call({:userone, id}, _from, state) do
    user = Accounts.get_user!(id)
    {:reply, user, state}
  end
end



#Example

# iex(1)> alias Gorm.Database
# Gorm.Database
# iex(2)> Database.start_link("redis://127.0.0.1:6379")
# [info] connect to url redis://127.0.0.1:6379
# {:ok, #PID<0.448.0>}
# iex(3)> {:ok, pid} =  Database.start_link("redis://127.0.0.1:6379")
# [info] connect to url redis://127.0.0.1:6379
# {:ok, #PID<0.452.0>}
# iex(4)> pid
# #PID<0.452.0>
# iex(5)> Database.check(pid)
# "PONG"
# iex(6)> Database.set(pid, "onetwo", "three")
# {:ok, {:ok, "OK"}}
# iex(7)> Database.get(pid, "onetwo")
# {:ok, {:ok, "three"}}
# iex(8)>


# 127.0.0.1:6379>  KEYS '*'
#  1) "queues"
#  2) "title"
#  3) "stat:failed:2019-09-06"
#  4) "stat:processed:2019-09-06"
#  5) "mykey"
#  6) "processes"
#  7) "stat:processed"
#  8) "stat:failed"
#  9) "onetwo"
# 10) "stat:processed:2019-09-04"
# 11) "stat:failed:2019-09-07"
# 12) "stat:failed:2019-09-04"
# 13) "stat:processed:2019-09-07"
# 14) "queue:default"
# 127.0.0.1:6379> GET onetwo
# "three"
# 127.0.0.1:6379>




