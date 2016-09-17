defmodule StaticBlog.PageController do
  use StaticBlog.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", posts: StaticBlog.Repo.list()
  end
end
