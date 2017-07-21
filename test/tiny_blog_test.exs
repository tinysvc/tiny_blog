defmodule TinyBlogTest do
  use ExUnit.Case
  doctest TinyBlog

  test "retrieving all blog posts" do
    {:ok, [post2, post1]} = TinyBlog.posts
    assert post1["slug"] == "test-post-1"
    assert post1["title"] == "Test Post 1"
    assert post1["html"] |> String.contains?("<h1>Test Post 1</h1>")
    assert post2["slug"] == "test-post-2"
    assert post2["title"] == "Test Post 2"
    assert post2["html"] |> String.contains?("<h1>Test Post 2</h1>")
    assert post2["custom_field"] == "extra info"
  end

  test "retrieving a single blog post by slug" do
    {:ok, post2} = TinyBlog.posts("test-post-2")
    assert post2["slug"] == "test-post-2"
    assert post2["title"] == "Test Post 2"
    assert post2["html"] |> String.contains?("<h1>Test Post 2</h1>")
    assert post2["custom_field"] == "extra info"
  end
end
