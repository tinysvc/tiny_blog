# TinyBlog

This is a super small library that reads a folder of markdown files and exposes them via an API.

## Installation

1. Install package
```elixir
def deps do
  [{:tiny_blog, "~> 0.1.0"}]
end
```
You may need to add the app to your applications list depending on the version of Elixir you're using.

2. Create a priv/blog_posts folder in your application and add at least one markdown file (.md extension)
3. Configure your app_name so TinyBlog can read your posts from a priv directory
```elixir
config :tiny_blog,
  app_name: :name_of_your_app,
  url: "http://example.org/posts",
  name: "Brandon's Blog",
  author: "Brandon Joyce
```

## Usage
Your blog posts should be formatted like this.  It's pretty much like Jekyll front-matter if you're familiar with that project.
```markdown
---
title: My Blog Post
date: 2017-07-20
another_field: Anything you want as long as it's valid yaml
---
Everything from here down will be markdown syntax

*Like lists and stuff*
- one
- two
- three
```

Now you can access your posts via API call to `TinyBlog.posts` which returns all posts in a list:
```elixir
{:ok, [
  %{"slug" => "my-blog-post", "title" => "My Blog Post", "html" => "markdown rendered html here", "another_field" => "..."},
  %{"slug" => "my-blog-post-2", "title" => "My Blog Post-2", "html" => "markdown rendered html here", "another_field" => "..."}
]}
```
or you can pass the a slug which will match the name of the file without the extension:
```
case TinyBlog.posts("my-blog-post") do
  {:ok, post} -> post
  _ -> nil # could not be found
end
```

