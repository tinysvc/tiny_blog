defmodule TinyBlog do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(TinyBlog.Posts, [])
    ]

    opts = [strategy: :one_for_one, name: TinyBlog]
    Supervisor.start_link(children, opts)
  end

  def posts(slug \\ nil) do
    TinyBlog.Posts.posts(slug)
  end
end
