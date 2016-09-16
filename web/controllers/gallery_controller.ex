defmodule StaticBlog.GalleryController do
  use StaticBlog.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", images: File.ls!("web/static/assets/images")
  end
end
