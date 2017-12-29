defmodule TextClient.Summary do

  alias TextClient.State

  def display(game = %State{ tally: tally }) do
    IO.puts [
      "\n",
      "Word so far: #{word_so_far(tally)}\n",
      "Guesses left: #{tally.turns_left}\n",
    ]
    game
  end

  defp word_so_far(tally) do
    tally.letters
    |> Enum.join(" ")
  end
end
