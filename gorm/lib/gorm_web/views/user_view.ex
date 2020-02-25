defmodule GormWeb.UserView do
  use GormWeb, :view
  use JaSerializer.PhoenixView

  attributes [:name, :email]
end
