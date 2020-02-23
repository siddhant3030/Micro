defmodule Gorm.Database do
  use GenServer
  require Logger
  alias Gorm.Accounts


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

# iex(3)> {:ok, conn} = Database.start_link("redis://localhost:6379/3")
# [info] connect to url redis://localhost:6379/3
# {:ok, #PID<0.458.0>}
# iex(4)> conn
# #PID<0.458.0>
# iex(5)> Database.check(conn)
# "PONG"

  def check(pid) do
    GenServer.call(pid, :check)
  end

  def handle_call(:check, _from, state) do
    checking = Redix.command!(state, ["PING"])
    {:reply, checking, state}
  end


  # def insert(key, value) do
  #   {:ok, conn} =   Redix.start_link("redis://localhost:6379/3", name: :redix)
  #   {:ok, reply} = Redix.command(conn, ["SET", key, value])
  # end

  # def fetch(pid, userone) do
  #   case get(pid) do
  #     {:not_found} -> set(pid, userone.())
  #     {:found, result} -> result
  #   end
  # end

  # defp get(pid) do
  #   case GenServer.call(pid, {:get, slug}) do
  #     [] -> {:not_found}
  #     [{_slug, result}] -> {:found, result}
  #   end
  # end

  def set({pid, key, value}) do
    GenServer.call(pid, {:set, key, value})
  end

  def handle_call({:set, key, value}, _from, state) do
    {:ok, reply} = Redix.command(state, ["SET", key, value])
    {:no_reply, reply, state}
  end

  # def handle_cast({:set, key, value}, _from, state) do
  #   {:ok, conn} = Redix.start_link("redis://localhost:6379/3", name: :redix)
  #   {:ok, reply} = Redix.command(state, ["SET", key, value])
  #   {:no_reply, user, state}
  # end


  def userone(pid, id) do
    GenServer.call(pid, {:userone, id})
  end

  def list(pid) do
    GenServer.call(pid, :list)
  end

  def handle_call(:list, _from, state) do
    my_models = Accounts.list_users()

    {:reply, my_models, state}
  end

  def handle_call({:userone, id}, _from, state) do
    user = Accounts.get_user!(id)
    {:reply, user, state}
  end
end




# Send the process after 10 seconds
# Process.send_after()







