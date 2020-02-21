defmodule Gorm.Database do
  use GenServer
  alias Gorm.Accounts


  @redis_connection_params host: Application.get_env(:gorm, :redis_host),
                           password: Application.get_env(:gorm, :redis_password),
                           port: Application.get_env(:gorm, :redis_port),
                           database: Application.get_env(:gorm, :redis_database)


  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    pool_opts = [
      worker_module: Redix,
      size: 10,
      max_overflow: 5
    ]

    children = [
      :poolboy.child_spec(pool_opts, @redis_connection_params)
    ]

    Supervisor.init(children, strategy: :one_for_one, name: __MODULE__)
  end

  # def get(pid, key) do
  #   GenServer.call(storage_pid, {:get, key})
  # end

  def set(, key, value) do
    GenServer.cast(pid, {:set, key, value})
  end

  def handle_cast({:set, key, value}, pid) do
    {:ok, pid} = Redix.command(pid, key, value)
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
    users = Accounts.get_user!(id)
    {:reply, users, state}
  end
end




# Send the process after 10 seconds
# Process.send_after()







