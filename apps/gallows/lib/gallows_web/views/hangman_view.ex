defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  def new_game_button(conn) do
    button("New Game", to: hangman_path(conn, :create_game))
  end

  def game_over?(:lost), do: true
  def game_over?(:won), do: true
  def game_over?(_), do: false

  @responses %{
    won: {:success, "You won!"},
    lost: {:danger, "You lost!"},
    good_guess: {:success, "Good guess!"},
    bad_guess: {:warning, "Bad guess!"},
    already_used: {:info, "You already guessed that..."}
  }

  def game_state(state) do
    @responses[state]
    |> alert()
  end

  defp alert(nil), do: ""

  defp alert({class, message}) do
    """
    <div class="alert alert-#{class}">
      #{message}
    </div>
    """
    |> raw()
  end
end
