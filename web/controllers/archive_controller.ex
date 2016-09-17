defmodule StaticBlog.ArchiveController do
  use StaticBlog.Web, :controller

  # change the default layout to post.html.eex inside template/layout
  plug :put_layout, "post.html"

  def index(conn, _params) do
    {:ok, posts} = StaticBlog.Repo.list()
    render conn, "index.html", posts: posts
  end

  def show(conn, %{"tag" => tag}) do
    {:ok, posts} = StaticBlog.Repo.get_by_tag(tag)
    render conn, "index.html", posts: posts
  end
end
