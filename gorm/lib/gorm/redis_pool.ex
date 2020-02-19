defmodule Gorm.RediPool do
  use GenServer

  @redis_connection_params host: Application.get_env(:gorm, :redis_host),
                           password: Application.get_env(:gorm, :redis_password),
                           port: Application.get_env(:gorm, :redis_port),
                           database: Application.get_env(:gorm, :redis_database)

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  def init([]) do
    pool_opts = [
      name: {:local, :redix_poolboy},
      worker_module: Redix,
      size: 10,
      max_overflow: 5,
    ]

    children = [
      :poolboy.child_spec(:redix_poolboy, pool_opts, @redis_connection_params)
    ]

    supervise(children, strategy: :one_for_one, name: __MODULE__)
  end
end
