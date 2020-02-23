defmodule Gorm.Database do
  use GenServer
  require Logger
  alias Gorm.Accounts

  # "redis://localhost:6379/3"


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

  def check(pid) do
    GenServer.call(pid, :check)
  end

  def handle_call(:check, _from, state) do
    checking = Redix.command!(state, ["PING"])
    {:reply, checking, state}
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  def handle_call({:get, key}, _from, state) do
    reply = Redix.command(state, ["GET", key])
    {:reply, {:ok, reply}, state}
  end

  def set(pid, key, value) do
    GenServer.call(pid, {:set, key, value})
  end

  def handle_call({:set, key, value}, _from, state) do
    reply = Redix.command(state, ["SET", key, value])
    {:reply, {:ok, reply}, state}
  end


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




