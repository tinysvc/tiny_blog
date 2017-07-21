defmodule TinyBlog.Posts do
  use GenServer
  @moduledoc """
  Holds the state for posts and blog properties.
  """

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_state) do
    posts = priv_path()
    |> Path.join("blog_posts")
    |> Path.join("*.md")
    |> Path.wildcard
    |> Enum.map(fn(filename) ->
      [yaml, body] = filename
      |> File.read!
      |> String.split("---\n", trim: true)

      path = filename
      |> String.split("/")
      |> List.last
      |> String.split(".")
      |> List.first

      {:ok, html, _} = Earmark.as_html(body)

      data = YamlElixir.read_from_string(yaml)

      %{"slug" => path, "html" => html, "markdown" => body}
      |> Map.merge(data)
    end)
    |> Enum.sort_by(fn(p) ->
      p["date"]
    end)
    |> Enum.reverse
    {:ok, [posts: posts]}
  end

  def posts(slug \\ nil) do
    case GenServer.call(__MODULE__, {:posts, slug}) do
      nil -> {:error, nil}
      result -> {:ok, result}
    end
  end

  def handle_call({:posts, slug}, _from, state) do
    result = case slug do
      nil -> state[:posts]
      _ -> Enum.find(state[:posts], fn(post) -> post["slug"] == slug end)
    end
    {:reply, result, state}
  end

  defp priv_path do
    app_name = Application.get_env(:tiny_blog, :app_name) || raise "Please configure the app_name for tiny_blog"
    :code.priv_dir(app_name)
  end
end
