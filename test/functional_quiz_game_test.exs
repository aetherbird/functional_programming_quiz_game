defmodule FunctionalQuizGameTest do
  use ExUnit.Case
  doctest FunctionalQuizGame

  test "greets the world" do
    assert FunctionalQuizGame.hello() == :world
  end
end
