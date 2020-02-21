defmodule Gorm.Database do
  use GenServer
  alias Gorm.Accounts
  alias Gorm.Accounts.User
  alias Gorm.Repo
  alias Gorm.RedisPool

  def start_link(args) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(list) do
    {:ok, []}
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  def set(pid, key, value) do
    Genserver.cast(pid, {:set, key, value})
  end

  def list(pid) do
    GenServer.call(pid, :list)
  end

  def handle_call(:list, _from, state) do
    my_models = Accounts.list_users()

    {:reply, my_models, state}
  end

  def handle_call({:get, key}, _from, storage_pid) do
    val = case RedisPool.retrieve(storage_pid, key) do
      {:ok, value} -> value
      nil -> nil
    end
    {:reply, val, storage_pid}
  end

  def handle_cast({:set, key, value}, storage_pid) do
    {:ok, _key} = RedisPool.insert(storage_pid, key, value)
end













