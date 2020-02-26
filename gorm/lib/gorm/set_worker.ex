defmodule Gorm.SetWorker do
  alias Gorm.Database

  def perform(conn, key, value) do
    Redix.command!(conn, ["SET", key, value])
  end
end
