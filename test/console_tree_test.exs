defmodule TreeTest do
  use ExUnit.Case
  import ConsoleTree

  def parse_item(%{"title" => title, "children" => children}) do
    {title, Enum.map(children, &parse_item/1)}
  end
  def parse_item(%{"title" => title}), do:
    {title, []}

  def parse(name) do
    File.read!("test/fixtures/#{name}.json")
    |> Poison.decode!
    |> parse_item
  end

  test "fixtures" do
    Path.wildcard("test/fixtures/*.json")
    |> Enum.map(fn filename ->
      Path.basename(filename, ".json")
    end)
    |> Enum.each(fn name ->
      tree = parse(name)
      text = File.read!("test/fixtures/#{name}.txt") |> String.strip

      assert render(tree, :ascii) == text
    end)
  end
end
