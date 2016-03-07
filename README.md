# ConsoleTree

Draws a representation of a tree structure, intended for use in a terminal environment.

    dev
    ├── consolidated
    │   ├── .compile.protocols
    │   ├── Elixir.Collectable.beam
    │   ├── Elixir.Enumerable.beam
    │   ├── Elixir.IEx.Info.beam
    │   ├── Elixir.Inspect.beam
    │   ├── Elixir.List.Chars.beam
    │   └── Elixir.String.Chars.beam
    └── lib
        └── console_tree
            ├── .compile.elixir
            ├── .compile.elixir_scm
            └── ebin
                ├── console_tree.app
                ├── Elixir.ConsoleTree.ASCII.beam
                ├── Elixir.ConsoleTree.beam
                └── Elixir.ConsoleTree.Boxes.beam

## Usage

Your data should be a nested tuple of the form `{title, children}`:

    {
      "Root",
      [
        {
          "Child",
          [
            {"Another child", []}
          ]
        }
      ]
    }

With your data prepared you can call either:

    ConsoleTree.print(root)

To print the resulting tree directly to stdout, or

    ConsoleTree.render(root)

to get the string representation back.

Rendering will use terminal line-drawing by default; you can specify `:ascii` as an optional second argument to either entry point to switch to basic ASCII drawing.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

    def deps do
      [
        {:console_tree, "~> 0.0.1"},
      ]
    end
