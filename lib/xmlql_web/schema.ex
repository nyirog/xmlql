defmodule XmlqlWeb.Schema do
  use Absinthe.Schema

  query do

    field :book_store, list_of(:book) do
      resolve fn _, _, _ ->
        {:ok, Xmlql.Model.BookStore.parse_xml()}
      end
    end

  end

  object :book do
    field :author, :string
    field :date, :string
    field :publisher, :string
    field :title, :string
  end
end
