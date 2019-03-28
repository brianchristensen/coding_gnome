defmodule TextClient.Summary do
  alias TextClient.State

  def display(game = %State{tally: tally}) do
    IO.puts [
      "_____________________________________________",
      "\n\n",
      "Word so far : #{tally.letters |> Enum.join(" ")}\n",
      "Guesses left: #{tally.turns_left}\n",
      "Already used: #{tally.used }\n"
    ]
    game
  end
end
