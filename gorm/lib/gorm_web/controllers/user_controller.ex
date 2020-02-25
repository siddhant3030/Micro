defmodule Gorm.UserController do
  use GormWeb, :controller
  alias Gorm.Accounts.User
  alias Gorm.Accounts

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

end
