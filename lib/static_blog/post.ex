defmodule StaticBlog.Post do
  defstruct path: "", title: "", date: "", intro: "", tags: [], content: ""

  def compile(dir, file) do
    post = %StaticBlog.Post{
      path: file_to_path(file)
    }

    Path.join([dir, file])
      |> File.read!
      |> split
      |> extract(post)
  end

  defp file_to_path(file) do
    String.replace(file, ~r/\.md$/, "")
  end

 defp split(blog) do
    [yaml, markdown] = String.split(blog, ~r/\n-{3,}\n/, parts: 2)
    {YamlElixir.read_from_string(yaml), Earmark.to_html(markdown)}
  end

  defp extract({props, content}, post) do
    %{post |
      title: props["title"],
      date: props["date"] |> Timex.parse!("{ISOdate}"),
      intro: props["intro"],
      tags: props["tags"],
      content: content}
  end
end
