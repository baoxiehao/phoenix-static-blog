defmodule StaticBlog.Awesome do
  defstruct url: "", title: "", tags: []

  def compile do
    Path.join("priv/awesome", "index.yaml")
    |> File.read!
    |> parse_yaml
    |> Enum.map(&extract(&1))
  end

  defp parse_yaml(yaml) do
    :yamerl_constr.string(yaml)
  end

  defp extract(props) do
    url = get_prop(props, "url")
    %StaticBlog.Awesome{
      url: url,
      title: get_url_title(url),
      tags: get_prop(props, "tags") |> String.split("@", trim: true),
    }
  end

  defp get_prop(props, key) do
    case :proplists.get_value(String.to_char_list(key), props) do
      :undefined -> nil
      x -> to_string(x)
    end
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
