defmodule AppTest do
  use ExUnit.Case

  test "App.hello_from_gleam should work" do
    assert is_binary(App.hello_from_gleam())
  end
end
