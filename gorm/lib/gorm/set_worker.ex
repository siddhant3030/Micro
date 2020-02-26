defmodule Gorm.SetWorker do

  def perform(key, value) do
    Redix.command!("SET", key, value)
  end
end
