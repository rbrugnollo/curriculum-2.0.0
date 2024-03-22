defmodule Games do
  @moduledoc """
  Documentation for `Games`.
  """
  def main(_args) do
    play()
  end

  defp play do
    option =
      IO.gets("""
      What game would you like to play?
      1. Guessing Game
      2. Rock Paper Scissors
      3. Wordle

      enter "stop" to exit
      """)
      |> String.trim()

    case option do
      "stop" ->
        :ok

      "1" ->
        Games.GuessingGame.play()
        play()

      "2" ->
        Games.RockPaperScissors.play()
        play()

      "3" ->
        Games.Wordle.play()
        play()
    end
  end
end
