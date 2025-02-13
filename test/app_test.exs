defmodule AppTest do
  use ExUnit.Case

  test "Calling gleam module directly should work" do
    assert is_binary(:app_gleam.hello())
  end

  test "Calling gleam from an elixir module should work" do
    assert is_binary(App.hello_from_gleam())
  end

  test "Calling gleam functions using tuples as types should work" do
    assert {:some, 0} == :gleam@option.from_result({:ok, 0})
  end

  test "Gleam records should be represented as tuples" do
    assert {:user, "user", "user@email", 0} == :app_gleam.new_user("user", "user@email", 0)
  end

  test "Calling external gleam library should work" do
    assert {:ok, "rgba(100.0%,100.0%,100.0%,1.0)"} =
             :gleam_community@colour.from_rgb255(255, 255, 255)
             |> :gleam@result.map(&:gleam_community@colour.to_css_rgba_string/1)
  end
end
