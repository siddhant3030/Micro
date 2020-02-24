defmodule Gorm.RedisPool do
  alias Gorm.Accounts

  def start_link(url), do: Redix.start_link(url)

  def check(conn), do: Redix.command!(conn, ["PING"])

  def get(conn, key), do: Redix.command!(conn, ["GET", key])

  def set(conn, key, value), do: Redix.command!(conn, ["SET", key, value])

  def user(id), do: Accounts.get_user!(id)
end
