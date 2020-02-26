defmodule Gorm.SetWorker do

  def perform(conn, key, value) do
    IO.inspect("oenas")
    Redix.command!(conn, ["SET", key, value])
  end
end
