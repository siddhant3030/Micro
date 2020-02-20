defmodule Gorm.Database do
  use GenServer
  alias Gorm.Accounts
  alias Gorm.Accounts.User
  alias Gorm.Repo

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(_args) do
    {:ok, []}
  end

  def list() do
    GenServer.call(__MODULE__, :list)
  end

  def handle_call(:list, _from, state) do
    my_models = Accounts.list_users()

    {:reply, my_models, state}
  end
end
