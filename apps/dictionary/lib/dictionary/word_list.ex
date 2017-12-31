defmodule Dictionary.WordList do
  use Agent

  def start_link() do
    Agent.start_link(&load_words/0, name: __MODULE__)
  end

  def random_word() do
    words = Agent.get(__MODULE__, fn words -> words end)
    words |> Enum.random()
  end

  defp load_words() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split("\n", trim: true)
  end
end
