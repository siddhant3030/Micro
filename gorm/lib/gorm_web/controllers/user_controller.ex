defmodule GormWeb.UserController do
  use GormWeb, :controller
  alias Gorm.Accounts.User
  alias Gorm.Accounts

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_bank(user_params) do
     conn
     |> put_status(:created)
     |> render("show.json-api", data: user)
   end
 end
end
