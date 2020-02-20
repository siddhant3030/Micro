defmodule Gorm.Database do
  use GenServer
  alias Gorm.Accounts
  alias Gorm.Accounts.User
  alias Gorm.Repo

  def start_link(args) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(list) do
    {:ok, []}
  end

  def list(pid) do
    GenServer.call(pid, :list)
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  def set(pid, key, value) do
    GenServer.call(pid, {:set, key, value})
  end

  def handle_call(:list, _from, state) do
    my_models = Accounts.list_users()

    {:reply, my_models, state}
  end
end
