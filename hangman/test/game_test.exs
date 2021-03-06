defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    assert MapSet.size(game.used) == 0
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [ :won, :lost ] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert { ^game, _tally } = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    { game, _tally }  = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    game = Game.new_game()
    { game, _tally }  = Game.make_move(game, "x")
    assert game.game_state != :already_used
    { game, _tally }  = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized and a guessed word is a won game" do
    game = Game.new_game("hi")
    { game, _tally }  = Game.make_move(game, "h")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    { game, _tally }  = Game.make_move(game, "i")
    assert game.game_state == :won
  end

  test "bad guess is recognized" do
    game = Game.new_game("hi")
    { game, _tally }  = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "invalid guess is recognized" do
    game = Game.new_game("hi")
    { game, _tally }  = Game.make_move(game, "ZXy")
    assert game.game_state == :invalid_guess
    assert game.turns_left == 7
  end

  test "lost game is recognized" do
    test_data = [
      {"a", :bad_guess, 6},
      {"b", :bad_guess, 5},
      {"c", :bad_guess, 4},
      {"d", :bad_guess, 3},
      {"e", :bad_guess, 2},
      {"f", :bad_guess, 1},
      {"g", :lost, 0}
    ]
    game = Game.new_game("hi")

    Enum.reduce(test_data, game, fn ({guess, game_state, turns_left}, game) ->
      { game, _tally }  = Game.make_move(game, guess)
      assert game.game_state == game_state
      assert game.turns_left == turns_left
      game
    end)
  end
end
