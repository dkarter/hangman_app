defmodule TextClient.Prompter do

  alias TextClient.State

  def accept_move(game = %State{}) do
    IO.gets("Your guess: ")
    |> check_input(game)
  end

  defp check_input({:error, reason}, _game) do
    exit_with_message("Game ended: #{reason}")
  end

  defp check_input(:eof, _game) do
    exit_with_message("Looks like you gave up...")
  end

  defp check_input(input, game = %State{}) do
    input = input |> String.trim()

    cond do
      input =~ ~r/\A[a-z]\z/ ->
        Map.put(game, :guess, input)

      true ->
        IO.puts "please enter a single lowercase letter"
        accept_move(game)
    end
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end
