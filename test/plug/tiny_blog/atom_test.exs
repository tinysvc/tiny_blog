defmodule Plug.TinyBlog.AtomTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test "returns an atom feed" do
    conn = conn(:get, "/atom.xml")
    result = Plug.TinyBlog.Atom.call(conn, nil)
    assert result.status == 200
    assert result.resp_body |> String.contains?("<title>Brandon's Blog</title>")
  end

  test "ignores other routes" do
    conn = conn(:get, "/random")
    result = Plug.TinyBlog.Atom.call(conn, nil)
    assert result == conn
  end
end
