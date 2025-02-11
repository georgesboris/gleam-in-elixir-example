defmodule App.MixProject do
  use Mix.Project

  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  # 
  # IMPORTANT!
  # As described in the README, `mix_gleam` needs to be installed in the system.
  # 
  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  @app :app

  def project do
    [
      app: @app,
      version: "0.0.1",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,

      # Fetch gleam dependencies alongside other dependencies.
      # The `gleam.deps.get` task is provided by `mix_gleam`.
      aliases: ["deps.get": ["deps.get", "gleam.deps.get"]],

      deps: [
        # Import Gleam project as a regular local dependency.
        # Internally, the project will be compiled to erlang through `mix_gleam`.
        {:app_gleam, path: "./app_gleam"}
      ]
    ]
  end
end
