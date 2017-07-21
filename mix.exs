defmodule TinyBlog.Mixfile do
  use Mix.Project
  @version "0.1.0"

  def project do
    [app: :tiny_blog,
     version: @version,
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     docs: [
       extras: ["README.md"],
       main: "readme",
       source_ref: "v#{@version}",
       source_url: "https://github.com/tinysvc/tiny_blog",
     ],
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      extra_applications: [:logger],
      mod: {TinyBlog, []}
    ]
  end

  defp description do
    """
    TinyBlog is a tiny library that turns a folder of markdown files into blog posts.
    """
  end

  defp package do
    [# These are the default files included in the package
     name: :tiny_blog,
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Brandon Joyce"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/tinysvc/tiny_blog",
      "Docs" => "https://github.com/tinysvc/tiny_blog"}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:yaml_elixir, "~> 1.3.0"},
      {:earmark, "~> 1.2"},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:plug, "~> 1.3.5"}
    ]
  end
end
