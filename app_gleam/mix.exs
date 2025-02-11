defmodule AppGleam.MixProject do
  use Mix.Project

  @app :app_gleam

  def project do
    [
      app: @app,
      version: "0.0.1",
      elixir: "~> 1.18",
      deps: deps(),

      # Gleam compilation
      archives: [mix_gleam: "~> 0.6.2"],
      compilers: [:gleam] ++ Mix.compilers(),
      aliases: ["deps.get": ["deps.get", "gleam.deps.get"]],
      erlc_paths: ["build/dev/erlang/#{@app}/_gleam_artefacts"],
      erlc_include_path: "build/dev/erlang/#{@app}/include",
      prune_code_paths: false
    ]
  end

  defp deps do
    [
      {:gleam_stdlib, ">= 0.40.0 and < 1.0.0"},

      # Unfortunately, we must add test dependencies as regular dependencies.
      # Otherwise compilation will fail with a warning of missing package.
      {:gleeunit, ">= 1.0.0 and < 2.0.0"}
    ]
  end
end
