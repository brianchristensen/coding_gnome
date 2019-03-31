defmodule TextClient.Player do
  alias TextClient.{Mover, Prompter, State, Summary}

  # won, lost, good_guess, bad_guess, already_used, invalid_input, initializing
  def play(%State{tally: tally = %{ game_state: :won }}) do
    exit_with_message("You WON! The word was: #{tally.word}")
  end

  def play(%State{tally: tally = %{ game_state: :lost }}) do
    exit_with_message("Sorry, you lost :( The word was: #{tally.word}")
  end

  def play(game = %State{tally: %{ game_state: :good_guess }}) do
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State{tally: %{ game_state: :bad_guess }}) do
    continue_with_message(game, "Sorry, that isn't in the word")
  end

  def play(game = %State{tally: %{ game_state: :already_used }}) do
    continue_with_message(game, "You already used that letter")
  end

  def play(game = %State{tally: %{ game_state: :initializing }}) do
    continue_with_message(game, "\nWelcome to Hangman!")
  end

  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  def display(game) do
    game
  end

  def prompt(game) do
    game
  end

  def make_move(game) do
    game
  end

  defp continue_with_message(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end
