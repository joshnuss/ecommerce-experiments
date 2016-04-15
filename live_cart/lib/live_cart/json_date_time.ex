defimpl Poison.Encoder, for: Timex.DateTime do
  def encode(d, _options) do
    fmt = Timex.format!(d, "{ISO}")
    "\"#{fmt}\""
  end
end
