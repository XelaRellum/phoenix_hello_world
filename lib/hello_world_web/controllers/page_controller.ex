defmodule HelloWorldWeb.PageController do
  use HelloWorldWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
