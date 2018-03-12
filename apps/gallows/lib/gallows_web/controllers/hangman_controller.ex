defmodule GallowsWeb.HangmanController do
  use GallowsWeb, :controller

  def new_game(conn, _params) do
    render(conn, "new_game.html")
  end

  def create_game(conn, _params) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)

    conn
    |> put_session(:game, game)
    |> render("game_field.html", tally: tally)
  end

  def make_move(conn, %{"make_move" => %{"guess" => guess}}) do
    tally =
      conn
      |> get_session(:game)
      |> Hangman.make_move(guess)

    conn
    |> Map.merge(%{params: %{}})
    |> render("game_field.html", tally: tally)
  end
end
