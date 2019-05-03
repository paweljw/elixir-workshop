defmodule Bar.Bartender do
  @moduledoc """
  Tends our very basic bar.
  """

  require IEx

  @doc """
    Randomizes the drink list
  """
  defdelegate randomize(drink_list), to: Enum, as: :shuffle

  @doc """
  Builds a list of what the bar serves.

  ## Examples

      iex> Bar.Bartender.drink_list
      ["Tyskie - 0,3l", "Tyskie - 0.5l", "Tyskie - 0,75l", "Tyskie - 2,5l",
      "Żywiec - 0,3l", "Żywiec - 0.5l", "Żywiec - 0,75l", "Żywiec - 2,5l",
      "Kasztelan - 0,3l", "Kasztelan - 0.5l", "Kasztelan - 0,75l",
      "Kasztelan - 2,5l", "Mocny Ful - 0,3l", "Mocny Ful - 0.5l",
      "Mocny Ful - 0,75l", "Mocny Ful - 2,5l"]
  """
  def drink_list do
    # volumes = ["0,3l", "0.5l", "0,75l", "2,5l"]
    # drinks = ["Tyskie", "Żywiec", "Kasztelan", "Mocny Ful"]
    volumes = Application.get_env(:bar, :volumes)
    drinks = Application.get_env(:bar, :drinks)

    for drink <- drinks, volume <- volumes do
      "#{drink} - #{volume}"
    end
  end

  @doc """
  Pours a random drink.
  """
  def pour_me_another do
    {[hand | _], _} = drink_list() |> randomize |> Enum.split(1)
    hand
  end
end
