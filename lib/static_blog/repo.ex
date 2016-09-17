defmodule StaticBlog.Repo do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, :ok, [name: __MODULE__])
  end

  def init(:ok) do
    posts = StaticBlog.Crawler.crawl_post("priv/posts")
    {:ok, posts}
  end

  def get_by_path(path) do
    GenServer.call(__MODULE__, {:get_by_path, path})
  end

  def get_by_tag(tag) do
    GenServer.call(__MODULE__, {:get_by_tag, tag})
  end

  def list() do
    GenServer.call(__MODULE__, {:list})
  end

  def handle_call({:get_by_path, path}, _from, posts) do
    case Enum.find(posts, fn(x) -> x.path == path end) do
      nil -> {:reply, :not_found, posts}
      post -> {:reply, {:ok, post}, posts}
    end
  end

  def handle_call({:get_by_tag, tag}, _from, posts) do
    tag_posts = Enum.filter(posts, fn post -> Enum.member?(post.tags, tag) end)
    {:reply, {:ok, tag_posts}, posts}
  end

  def handle_call({:list}, _from, posts) do
    {:reply, {:ok, posts}, posts}
  end
end
