defmodule Greeting do
  @moduledoc """
  Documentation for `Greeting`.
  """

  def main(args) do
    {opts, _word, _errors} = OptionParser.parse(args, switches: [time: :string, upcase: :boolean])
    greeting = "Good #{opts[:time] || "morning"}!"
    greeting = (opts[:upcase] && String.upcase(greeting)) || greeting
    IO.puts(greeting)
  end
end
