defmodule PaintByNumber do
  def get_palette_bit_size(color_count, n) do
    if(2 ** n >= color_count) do
      n
    else
      get_palette_bit_size(color_count,n+1)
    end

  end
  def palette_bit_size(color_count) do
    get_palette_bit_size(color_count,1)


  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2,1::2,2::2,3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    bs = palette_bit_size(color_count)
    <<pixel_color_index::size(bs), picture::bitstring>>
  end
  def get_first_pixel(<<>>, _color_count) do
    nil
  end

  def get_first_pixel(picture, color_count) do
    bs = palette_bit_size(color_count)
    <<h::size(bs), _tail::bitstring>> = picture
    h
  end
  def drop_first_pixel(<<>>, _color_count) do
    empty_picture()
  end

  def drop_first_pixel(picture, color_count) do
    bs = palette_bit_size(color_count)
    <<_h::size(bs), tail::bitstring>> = picture
    tail
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
