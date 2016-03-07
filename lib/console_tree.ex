defmodule ConsoleTree do
  @width 3

  def print(leaf = {_, children}, style \\ :boxes) when is_list(children) do
    render(leaf, style)
    |> IO.puts
  end

  def render(leaf = {_, children}, style \\ :boxes) when is_list(children) do
    case style do
      :boxes -> render_with(leaf, ConsoleTree.Boxes)
      :ascii -> render_with(leaf, ConsoleTree.ASCII)
      _ ->
        raise "Unknown rendering style '#{style}'"
    end
  end

  defp render_with(leaf, drawing) do
    render_siblings([leaf], [], drawing)
    |> Enum.join("\n")
  end

  defp prefixes_for(is_last_item_at_depths, drawing, prefixes \\ [])

  defp prefixes_for([_], _, prefixes), do:
    Enum.join(prefixes, " ")

  defp prefixes_for([is_last_item | is_last_item_at_depths], drawing, prefixes) do
    is_max_depth = prefixes == []

    prefix = drawing.prefix_for(is_max_depth, is_last_item, @width)

    prefixes_for(is_last_item_at_depths, drawing, [prefix | prefixes])
  end

  # Root item title is always printed alone on the first line
  defp text_for_row(str, [true], _), do:
    str

  defp text_for_row(str, is_last_item_at_depths, drawing), do:
    prefixes_for(is_last_item_at_depths, drawing) <> " " <> str

  defp render_leaf({title, children}, is_last_item_at_depths, drawing) when is_list(children) do
    title_row = text_for_row(title, is_last_item_at_depths, drawing)

    child_rows = render_siblings(children, is_last_item_at_depths, drawing)

    [title_row | child_rows]
  end

  defp render_siblings(siblings, is_last_item_at_depths, drawing, rows \\ [])

  defp render_siblings([], _, _, rows), do:
    rows

  defp render_siblings([leaf | siblings], is_last_item_at_depths, drawing, rows) do
    rows = rows ++ render_leaf(leaf, [siblings == [] | is_last_item_at_depths], drawing)

    render_siblings(siblings, is_last_item_at_depths, drawing, rows)
  end
end
