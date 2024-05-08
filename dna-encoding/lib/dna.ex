defmodule DNA do
  def encode_nucleotide(code_point) do
    cp = case code_point do
      ?\s -> 0
      ?A -> 1
      ?C -> 2
      ?G -> 4
      ?T -> 8
    end
    cp

  end

  def decode_nucleotide(encoded_code) do
    cp = case encoded_code do
      0 -> ?\s
      1 -> ?A
      2 -> ?C
      4 -> ?G
      8 -> ?T
    end
    cp
  end

  def encode(dna) do
    doencode(dna,<<>>)
  end
  def doencode([],acc), do: acc
  def doencode([it | rest], acc) do
    doencode(rest, <<acc::bitstring, encode_nucleotide(it)::4>>)

  end

  def decode(dna) do
    dodecode(dna,[])
  end
  def dodecode(<<>>,acc), do: acc
  def dodecode(<<it::4, rest::bitstring>>,acc) do
    dodecode(rest, acc ++ [decode_nucleotide(it)])
  end



end
