defmodule Username do
  def recur([]) do
    ~c""
  end
  def recur([fl|ll]) do
    cleaned =
    case fl do
      ?ß -> 'ss'
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      x when (x>= ?a and x<=?z) -> [x]
      ?_ -> '_'
      _ -> ''
    end
    cleaned ++ recur(ll)
  end
  def sanitize(username) do
    # ä becomes ae
    # ö becomes oe
    # ü becomes ue
    # ß becomes ss
    recur(username)

  end
end
