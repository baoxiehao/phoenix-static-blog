defmodule StaticBlog.AboutController do
  use StaticBlog.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", content:
      "priv/about/me.md"
      |> File.read!()
      |> Earmark.to_html()
  end
end
