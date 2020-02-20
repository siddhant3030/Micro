defmodule Gorm.DatabaseTest do
  use ExUnit.Case
  alias Gorm.Accounts
  alias Gorm.Accounts.User
  alias Gorm.Repo
  alias Gorm.Database

  test "test" do
    assert [] = Database.handle_call(:list, make_ref(), %{})

    Accounts.Repo.insert!(%User{name: "good", email: "ssiddhant@gmail.com"})

    assert {:reply, [my_model], %{}} = Database.handle_call(:list, make_ref(), %{})
  end
end
