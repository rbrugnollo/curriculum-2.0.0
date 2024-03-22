defmodule Games.Wordle do
  @words ["toast", "tarts", "hello", "beats"]
  @type color :: :green | :yellow | :gray
  @type colors :: [color()]
  @moduledoc """
  Wordle Game
  """

  @spec play(String.t() | nil, integer()) :: :ok
  def play(answer \\ nil, attempt \\ 1) do
    answer = answer || Enum.random(@words)
    guess = IO.gets("Enter a five letter word: ") |> String.trim()

    cond do
      answer === guess ->
        IO.puts("You win! #{answer} is the correct answer")

      attempt === 6 ->
        IO.puts("You lose! The answer was #{answer}!")

      true ->
        feedback(answer, guess)
        |> colored_feedback(guess)
        |> IO.puts()

        play(answer, attempt + 1)
    end
  end

  @spec feedback(String.t(), String.t()) :: colors()
  def feedback(answer, guess) do
    handle_greens(String.split(answer, "", trim: true), String.split(guess, "", trim: true))
    |> handle_yellows()
    |> handle_grays()
  end

  @spec colored_feedback(colors(), String.t()) :: String.t()
  defp colored_feedback(colors, guess) do
    colored_text =
      Enum.zip(colors, String.split(guess, "", trim: true))
      |> Enum.map_join(
        fn
          {:green, char} -> IO.ANSI.green() <> char
          {:yellow, char} -> IO.ANSI.yellow() <> char
          {:grey, char} -> IO.ANSI.light_black() <> char
        end,
        ""
      )

    colored_text <> IO.ANSI.reset()
  end

  @spec handle_greens([String.t()], [String.t()]) :: {[String.t() | nil], [String.t() | color()]}
  defp handle_greens(answer_list, guess_list) do
    Enum.zip(answer_list, guess_list)
    |> Enum.map(fn zip ->
      case zip do
        {same, same} -> {nil, :green}
        not_green -> not_green
      end
    end)
    |> Enum.unzip()
  end

  @spec handle_yellows({[String.t() | nil], [String.t() | color()]}) ::
          {[String.t() | nil], [String.t() | color()]}
  defp handle_yellows({answer_list, guess_list}) do
    Enum.reduce(guess_list, {answer_list, []}, fn guess_char, {answer_acc, guess_acc} ->
      if guess_char in answer_acc do
        {
          List.replace_at(
            answer_acc,
            Enum.find_index(answer_acc, fn el -> el === guess_char end),
            nil
          ),
          guess_acc ++ [:yellow]
        }
      else
        {answer_acc, guess_acc ++ [guess_char]}
      end
    end)
  end

  @spec handle_yellows({[String.t() | nil], [String.t() | color()]}) ::
          {[String.t() | nil], [String.t() | color()]}
  defp handle_grays({_answer_list, guess_list}) do
    guess_list
    |> Enum.map(fn m ->
      if m in [:green, :yellow] do
        m
      else
        :gray
      end
    end)
  end
end
