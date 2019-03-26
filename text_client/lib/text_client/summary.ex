defmodule TextClient.Summary do
  alias TextClient.State

  def display(game = %State{tally: tally}) do
    IO.puts [
      "_____________________________________________",
      "\n\n",
      "Word so far : #{tally.letters |> Enum.join(" ")}\n",
      "Guesses left: #{tally.turns_left}\n",
      "Already used: #{game.game_service.used |> MapSet.to_list() |> Enum.sort() |> Enum.join(" ")}\n"
    ]
    game
  end
end
