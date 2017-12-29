defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  describe ".new_game" do
    test "returns structure" do
      game = Game.new_game()

      assert game.turns_left == 7
      assert game.game_state == :initializing
      assert length(game.letters) > 0
    end
  end

  describe ".make_move" do
    test "returns the same state if game is :won or :lost" do
      for state <- [:won, :lost] do
        game = Game.new_game() |> Map.put(:game_state, state)
        assert ^game = Game.make_move(game, "x")
      end
    end

    test "changes state to :already_used if letter already used" do
      game = Game.new_game()
      game = Game.make_move(game, "s")
      assert game.game_state != :already_used
      game = Game.make_move(game, "s")
      assert game.game_state == :already_used
    end

    test "returns new state containing new guesses that have not been used yet" do
      game = Game.new_game()
      game = Game.make_move(game, "s")
      assert game.game_state != :already_used
      assert MapSet.member?(game.used, "s")
    end

    test "game is won when all letters have been guessed correctly" do
      game = Game.new_game("wibble")
      game = Game.make_move(game, "w")
      assert game.game_state == :good_guess
      assert game.turns_left == 7

      game = Game.make_move(game, "i")
      assert game.game_state == :good_guess
      assert game.turns_left == 7

      game = Game.make_move(game, "b")
      assert game.game_state == :good_guess
      assert game.turns_left == 7

      game = Game.make_move(game, "l")
      assert game.game_state == :good_guess
      assert game.turns_left == 7

      game = Game.make_move(game, "e")
      assert game.game_state == :won
      assert game.turns_left == 7
    end

    test "bad game is recognized" do
      game = Game.new_game("wibble")
      game = Game.make_move(game, "x")
      assert game.game_state == :bad_guess
      assert game.turns_left == 6
    end

    test "state change to lost after all turns have been used up" do
      game = Game.new_game("wibble")
      game = Game.make_move(game, "x")
      game = Game.make_move(game, "q")
      game = Game.make_move(game, "u")
      game = Game.make_move(game, "t")
      game = Game.make_move(game, "o")
      game = Game.make_move(game, "p")
      game = Game.make_move(game, "m")
      assert game.game_state == :lost
      assert game.turns_left == 0
    end

    test "state changes to :invalid_guess when guess is more than 1 character" do
      game = Game.new_game()
             |> Game.make_move("xy")
      assert game.game_state == :invalid_guess
    end
  end
end
