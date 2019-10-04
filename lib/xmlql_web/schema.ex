defmodule XmlqlWeb.Schema do
  use Absinthe.Schema

  alias XmlqlWeb.Resolvers

  query do

    field :book_store, list_of(:book) do
      resolve &Resolvers.BookStore.list_books/3
    end

  end

  object :book do
    field :ISBN, :id, name: "isbn"
    field :author, :string
    field :date, :string
    field :publisher, :string
    field :title, :string
  end
end
