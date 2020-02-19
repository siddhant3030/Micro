defmodule Gorm.RediPool do
  use GenServer

  @redis_connection_params host: Application.get_env(:gorm, :redis_host),
                           password: Application.get_env(:gorm, :redis_password),
                           port: Application.get_env(:gorm, :redis_port),
                           database: Application.get_env(:gorm, :redis_database)

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end
end
