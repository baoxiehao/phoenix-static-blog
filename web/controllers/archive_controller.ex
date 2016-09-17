defmodule StaticBlog.ArchiveController do
  use StaticBlog.Web, :controller

  # change the default layout to post.html.eex inside template/layout
  plug :put_layout, "post.html"

  def index(conn, _params) do
    render conn, "index.html", posts: StaticBlog.Repo.list()
  end

  def show(conn, %{"tag" => tag}) do
    render conn, "index.html", posts: StaticBlog.Repo.get_by_tag(tag)
  end
end
