defmodule FileSniffer do
  def type_from_extension(extension) do
    case extension do
      "exe" -> "application/octet-stream"
      "bmp" -> "image/bmp"
      "png" -> "image/png"
      "jpg" -> "image/jpg"
      "gif" -> "image/gif"
      _ -> nil
    end

  end

  def type_from_binary(file_binary) do
    case file_binary do
      <<0x7f,0x45,0x4c,0x46,_::binary>> -> "application/octet-stream"
      <<0x42,0x4d,_::binary>> -> "image/bmp"
      <<0x89,0x50,0x4e,0x47,0x0d,0x0a,0x1a,0x0a,_::binary>> -> "image/png"
      <<0xff,0xd8,0xff,_::binary>> -> "image/jpg"
      <<0x47,0x49,0x46,_::binary>> -> "image/gif"
      <<_::bitstring>>->nil
    end
  end

  def verify(file_binary, extension) do
    d = type_from_extension(extension)
    e = type_from_binary(file_binary)
    case (d==e and d !== nil) do
      true -> {:ok, d}
      false ->{:error, "Warning, file format and file extension do not match."}
    end
  end
end
