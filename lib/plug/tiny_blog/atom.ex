defmodule Plug.TinyBlog.Atom do
  import Plug.Conn

  @moduledoc """
  Plug for providing an atom.xml feed of your blog posts.
  """

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    case conn.path_info == ["atom.xml"] do
      true -> send_atom_xml(conn)
      false -> conn
    end
  end

  defp send_atom_xml(conn) do
    conn
    |> put_resp_content_type("application/atom+xml")
    |> send_resp(200, build_xml())
    |> halt
  end

  defp build_xml do
    {:ok, posts} = TinyBlog.posts
    :tiny_blog
    |> :code.priv_dir
    |> Path.join("atom.xml.eex")
    |> File.read!
    |> EEx.eval_string(posts: posts)
  end
end
