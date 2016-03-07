defmodule ConsoleTree.ASCII do
  def prefix_for(is_max_depth, is_last_item, width)

  def prefix_for(false, true, width), do:
    String.duplicate(" ", width)

  def prefix_for(false, false, width), do:
    "|" <> String.duplicate(" ", width-1)

  def prefix_for(true, true, width), do:
    "`" <> String.duplicate("-", width-1)

  def prefix_for(true, false, width), do:
    "|" <> String.duplicate("-", width-1)
end

defmodule ConsoleTree.Boxes do
  defp char_for_type(type) do
    case type do
    :vertical   -> <<0x78>> # │
    :tee        -> <<0x74>> # ├
    :bottom     -> <<0x6D>> # └
    :horizontal -> <<0x71>> # ─
    end
  end

  defp box(types) do
    chars =
      types
      |> Enum.map(&char_for_type/1)
      |> Enum.join
    <<0x1B, "(0">> <> chars <> <<0x1B, "(B">>
  end

  def prefix_for(is_max_depth, is_last_item, width)

  def prefix_for(false, true, width), do:
    String.duplicate(" ", width)

  def prefix_for(false, false, width), do:
    box([:vertical]) <> String.duplicate(" ", width-1)

  def prefix_for(true, true, width), do:
    box([:bottom | List.duplicate(:horizontal, width-1)])

  def prefix_for(true, false, width), do:
    box([:tee | List.duplicate(:horizontal, width-1)])
end
