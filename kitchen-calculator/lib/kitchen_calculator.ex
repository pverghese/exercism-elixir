defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    {_,volume} = volume_pair
    volume
  end

  def to_milliliter({:cup, volume}) do
    {:milliliter, volume*240}
  end
  def to_milliliter({:milliliter, volume}) do
    {:milliliter, volume}
  end
  def to_milliliter({:fluid_ounce, volume}) do
    {:milliliter, volume*30}
  end
  def to_milliliter({:teaspoon, volume}) do
    {:milliliter, volume*5}
  end
  def to_milliliter({:tablespoon, volume}) do
    {:milliliter, volume*15}
  end

  def from_milliliter(volume_pair, :cup) do
    {_, ml} = to_milliliter(volume_pair)
   {:cup, ml / 240}
  end
  def from_milliliter(volume_pair, :fluid_ounce) do
    {_, ml} = to_milliliter(volume_pair)
    {:fluid_ounce, ml / 30}
  end
  def from_milliliter(volume_pair, :teaspoon) do
    {_, ml} = to_milliliter(volume_pair)
    {:teaspoon, ml / 5}
  end
  def from_milliliter(volume_pair, :tablespoon) do
    {_, ml} = to_milliliter(volume_pair)
    {:tablespoon, ml / 15}
  end
  def from_milliliter(volume_pair, :milliliter) do
    {_, ml} = to_milliliter(volume_pair)
    {:milliliter, ml}
  end

  def convert(volume_pair, unit) do
    from_milliliter(volume_pair, unit)
  end
end
