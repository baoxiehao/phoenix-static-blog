defmodule StaticBlog.Awesome do
  defstruct url: "", title: "", tags: []

  def compile do
    Path.join("priv/awesome", "index.yaml")
    |> YamlElixir.read_all_from_file
    |> Enum.map(&extract(&1))
  end

  defp extract(props) do
    url = props["url"]
    %StaticBlog.Awesome{
      url: url,
      title: get_url_title(url),
      tags: props["tags"],
    }
  end

  defp get_url_title(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        [{_, _, [title]}] = Floki.find(body, "title")
        String.trim(title)
      {_, _} ->
        url
    end
  end
end
