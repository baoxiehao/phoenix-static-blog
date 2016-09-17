defmodule StaticBlog.AboutController do
  use StaticBlog.Web, :controller

  # change the default layout to post.html.eex inside template/layout
  plug :put_layout, "post.html"

  def index(conn, _params) do
    render conn, "index.html", content:
      "priv/about/me.md"
      |> File.read!()
      |> Earmark.to_html()
  end
end
