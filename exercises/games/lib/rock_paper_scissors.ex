defmodule Games.RockPaperScissors do
  @moduledoc """
    Play Rock Paper Scissors on the terminal
  """

  @spec play :: :ok
  def play do
    ai_choice = Enum.random(["rock", "paper", "scissors"])
    user_choice = IO.gets("Choose rock, paper, or scissors: ") |> String.trim()

    winning_combinations = [{"rock", "scissors"}, {"scissors", "paper"}, {"paper", "rock"}]

    cond do
      user_choice === ai_choice ->
        IO.puts("It's a tie!")

      {user_choice, ai_choice} in winning_combinations ->
        IO.puts("You win! #{user_choice} beats #{ai_choice}.")

      {ai_choice, user_choice} in winning_combinations ->
        IO.puts("You lose! #{ai_choice} beats #{user_choice}.")
    end
  end
end
