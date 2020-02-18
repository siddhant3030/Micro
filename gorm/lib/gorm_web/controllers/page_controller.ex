defmodule GormWeb.PageController do
  use GormWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
