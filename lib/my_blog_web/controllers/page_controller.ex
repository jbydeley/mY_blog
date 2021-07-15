defmodule MyBlogWeb.PageController do
  use MyBlogWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end
end
