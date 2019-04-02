defmodule SocketGallowsWeb.HangmanChannel do
  use Phoenix.Channel

  require Logger

  def join("hangman:game", _, socket) do
    game = Hangman.new_game()
    socket = assign(socket, :game, game)
    { :ok, socket }
  end

  def handle_in("new_game", _, socket) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    socket = assign(socket, :game, game)
    push(socket, "tally", tally)
    { :noreply, socket }
  end

  def handle_in("tally", _, socket) do
    tally = socket.assigns.game |> Hangman.tally()
    push(socket, "tally", tally)
    { :noreply, socket }
  end

  def handle_in("make_move", guess, socket) do
    tally = socket.assigns.game |> Hangman.make_move(guess)
    push(socket, "tally", tally)
    { :noreply, socket }
  end

  def handle_in(unmatched, _, socket) do
    Logger.error("Unmatched socket push received: #{unmatched}")
    { :noreply, socket }
  end
end
