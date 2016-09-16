defmodule StaticBlog.Crawler do

  def crawl_post(dir) do
    File.ls!(dir)
    |> Enum.filter(&String.ends_with?(&1, ".md"))
    |> IO.inspect
    |> Enum.map(&StaticBlog.Post.compile(dir, &1))
    |> Enum.sort(&sort/2)
  end

  def sort(a, b) do
    Timex.compare(a.date, b.date) > 0
  end
end
