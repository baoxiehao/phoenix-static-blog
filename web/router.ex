defmodule StaticBlog.Router do
  use StaticBlog.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StaticBlog do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/post/:path", PostController, :show

    get "/archive", ArchiveController, :index
    get "/archive/:tag", ArchiveController, :show

    get "/awesome", AwesomeController, :index
    get "/awesome/:tag", AwesomeController, :show

    get "/gallery", GalleryController, :index

    get "/about", AboutController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", StaticBlog do
  #   pipe_through :api
  # end
end
