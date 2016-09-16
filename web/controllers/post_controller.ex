defmodule StaticBlog.PostController do
  use StaticBlog.Web, :controller

  def show(conn, %{"path" => path}) do
    case StaticBlog.Repo.get_by_path(path) do
      {:ok, post} -> render conn, "show.html", post: post
      :not_found -> not_found(conn)
    end
  end

  def not_found(conn) do
    conn
    |> put_status(:not_found)
    |> render(StaticBlog.ErrorView, "404.html")
  end
end
