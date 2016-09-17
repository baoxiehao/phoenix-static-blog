defmodule StaticBlog.Watcher do
  use GenServer

  @dir "priv/posts"
  @interval 5_000

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: :watcher)
  end

  def init(_args) do
    :timer.send_interval(@interval, :watch)
    {:ok, get_mtimes}
  end

  def handle_info(:watch, mtimes) do
    new_mtimes = get_mtimes
    if not MapSet.equal?(new_mtimes, mtimes) do
      diff_files = diff_files(mtimes, new_mtimes);
      StaticBlog.Repo.update(diff_files)
    end
    {:noreply, new_mtimes}
  end

  defp get_mtimes do
    @dir
    |> File.ls!
    |> Stream.map(fn file -> {file, File.lstat(Path.join(@dir, file))} end)
    |> Stream.map(fn {file, {:ok, %File.Stat{mtime: mtime}}} -> {file, mtime} end)
    |> Enum.into(MapSet.new)
  end

  defp diff_files(mtimes, new_mtimes) do
    MapSet.difference(MapSet.union(mtimes, new_mtimes), MapSet.intersection(mtimes, new_mtimes))
    |> Enum.map(fn {file, _mtime} -> file end)
    |> Enum.uniq
  end
end
