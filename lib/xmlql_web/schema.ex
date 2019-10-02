defmodule XmlqlWeb.Schema do
  use Absinthe.Schema

  query do

    field :menu_items, list_of(:menu_item) do
      resolve fn _, _, _ ->
        {:ok, []}
      end
    end

  end

  object :menu_item do
    field :id, :id
    field :name, :string
    field :description, :string
  end


end
