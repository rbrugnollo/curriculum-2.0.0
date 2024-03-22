defmodule Games.GuessingGame do
  @moduledoc """
  Game where users can guess a number from 1 to 10.
  """
  def play do
    value = Enum.random(1..10)
    guess = IO.gets("Guess a number from 1 to 10: ")
    check_guess(guess, value)
  end

  defp check_guess(guess, value, attempt \\ 1) do
    {guess_int, _} = Integer.parse(guess)

    cond do
      guess_int === value ->
        IO.puts("You win!")

      attempt >= 5 ->
        IO.puts("You lose! the answer was #{value}")

      guess_int > value ->
        IO.puts("Too high!")
        guess = IO.gets("Enter your guess (attempt: #{attempt + 1}): ")
        check_guess(guess, value, attempt + 1)

      guess_int < value ->
        IO.puts("Too Low!")
        guess = IO.gets("Enter your guess (attempt: #{attempt + 1}): ")
        check_guess(guess, value, attempt + 1)
    end
  end
end
