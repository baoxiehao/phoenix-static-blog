defmodule StaticBlog.PostController do
  use StaticBlog.Web, :controller

  # change the default layout to post.html.eex inside template/layout
  plug :put_layout, "post.html"

  def show(conn, %{"path" => path}) do
    case StaticBlog.Repo.get_by_path(path) do
      :not_found -> not_found(conn)
      post -> render conn, "show.html", post: post
    end
  end

  def not_found(conn) do
    conn
    |> put_status(:not_found)
    |> render(StaticBlog.ErrorView, "404.html")
  end
end
