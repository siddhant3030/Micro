defmodule Gorm.Database do
  use GenServer
  alias Gorm.Accounts
  alias Gorm.RedisPool

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_list) do
    {:ok, []}
  end

  def userone(pid, id) do
    GenServer.call(pid, {:userone, id})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  def set(pid, key, value) do
    GenServer.cast(pid, {:set, key, value})
  end

  def list(pid) do
    GenServer.call(pid, :list)
  end

  def handle_call(:list, _from, state) do
    my_models = Accounts.list_users()

    {:reply, my_models, state}
  end

  def handle_call({:userone, id}, _from, state) do
    users = Accounts.get_user!(id)
    {:reply, users, state}
  end

  def handle_cast({:set, key, value}, pid) do
  {:ok, _key} = RedisPool.insert(pid, key, value)
  {:noreply, pid}
  end
end




# Send the process after 10 seconds
# Process.send_after()







