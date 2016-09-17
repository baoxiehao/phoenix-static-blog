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
    {parse_yaml(yaml), Earmark.to_html(markdown)}
  end

  defp parse_yaml(yaml) do
    [parsed] = :yamerl_constr.string(yaml)
    IO.inspect parsed
    parsed
  end

  defp extract({props, content}, post) do
    %{post |
      title: get_prop(props, "title"),
      date: get_prop(props, "date") |> Timex.parse!("{ISOdate}"),
      intro: get_prop(props, "intro"),
      tags: get_prop(props, "tags") |> String.split("@", trim: true),
      content: content}
  end

  defp get_prop(props, key) do
    case :proplists.get_value(String.to_char_list(key), props) do
      :undefined -> nil
      x -> to_string(x)
    end
  end
end
