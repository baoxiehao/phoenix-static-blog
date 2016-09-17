defmodule StaticBlog.Repo do
  use GenServer

  @dir "priv/posts"

  def start_link do
    GenServer.start_link(__MODULE__, nil, [name: __MODULE__])
  end

  def init(_args) do
    {:ok, update_post(File.ls!(@dir), [])}
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

  def update(files) do
    GenServer.cast(__MODULE__, {:update, files})
  end

  def handle_call({:get_by_path, path}, _from, posts) do
    case Enum.find(posts, fn {_file, post} -> post.path == path end) do
      nil -> {:reply, :not_found, posts}
      {_file, post} -> {:reply, post, posts}
    end
  end

  def handle_call({:get_by_tag, tag}, _from, posts) do
    {
      :reply,
      posts
        |> Enum.filter_map(
            fn {_file, post} -> Enum.member?(post.tags, tag) end,
            fn {_file, post} -> post end),
      posts
    }
  end

  def handle_call({:list}, _from, posts) do
    {
      :reply,
      posts |> Enum.map(fn {_file, post} -> post end),
      posts
    }
  end

  def handle_cast({:update, files}, posts) do
    IO.puts "Update post: #{inspect files}"
    {:noreply, update_post(files, posts)}
  end

  defp update_post(files, posts) do
    new_posts =
      files
      |> IO.inspect # debug output
      |> Enum.map(fn file -> {file, StaticBlog.Post.compile(@dir, file)} end)

    posts
      |> Enum.reject(fn {file, _post} -> Enum.member?(files, file) end)
      |> Enum.concat(new_posts)
      |> Enum.sort(&sort/2)
  end

  defp sort({_file1, post1}, {_file2, post2}) do
    Timex.compare(post1.date, post2.date) > 0
  end
end
