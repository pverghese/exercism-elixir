defmodule RPG.CharacterSheet do
  def welcome() do
    IO.puts("Welcome! Let's fill out your character sheet together.")
    :ok
  end

  def ask_name() do
    input = IO.gets("What is your character's name?\n")
    input |> String.trim()

  end

  def ask_class() do
    input = IO.gets("What is your character's class?\n")
    input |> String.trim()
  end

  def ask_level() do
    input = IO.gets("What is your character's level?\n")
    input |> String.trim() |> String.to_integer()
  end

  def run() do
    welcome()
    name = ask_name()
    class = ask_class()
    level = ask_level()
    player = %{class: class, level: level, name: name}
    IO.inspect(player, label: "Your character")
  end
end
