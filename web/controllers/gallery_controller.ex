defmodule StaticBlog.GalleryController do
  use StaticBlog.Web, :controller

  # change the default layout to post.html.eex inside template/layout
  plug :put_layout, "post.html"

  def index(conn, _params) do
    render conn, "index.html", images: File.ls!("web/static/assets/images")
  end
end
