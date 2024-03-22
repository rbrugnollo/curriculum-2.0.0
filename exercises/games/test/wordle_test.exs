defmodule Games.WordleTest do
  use ExUnit.Case

  test "All green when answer is correct" do
    assert Games.Wordle.feedback("toast", "toast") === [:green, :green, :green, :green, :green]
    assert Games.Wordle.feedback("aaaaa", "aaaaa") === [:green, :green, :green, :green, :green]
    assert Games.Wordle.feedback("trout", "trout") === [:green, :green, :green, :green, :green]
  end

  test "All yellow when chars not in correct position" do
    assert Games.Wordle.feedback("abcde", "bcdea") === [
             :yellow,
             :yellow,
             :yellow,
             :yellow,
             :yellow
           ]

    assert Games.Wordle.feedback("pqrst", "tpqrs") === [
             :yellow,
             :yellow,
             :yellow,
             :yellow,
             :yellow
           ]
  end

  test "All gray when chars not in string" do
    assert Games.Wordle.feedback("abcde", "pqrst") === [
             :gray,
             :gray,
             :gray,
             :gray,
             :gray
           ]

    assert Games.Wordle.feedback("pqrst", "abcde") === [
             :gray,
             :gray,
             :gray,
             :gray,
             :gray
           ]
  end

  test "Mixed colors" do
    assert Games.Wordle.feedback("toast", "tarts") === [:green, :yellow, :gray, :yellow, :yellow]
    assert Games.Wordle.feedback("XXXAA", "AAAAY") === [:yellow, :gray, :gray, :green, :gray]
  end
end
