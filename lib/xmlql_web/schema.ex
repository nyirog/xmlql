defmodule XmlqlWeb.Schema do
  use Absinthe.Schema

  alias XmlqlWeb.Resolvers

  query do

    field :book_store, list_of(:book) do
      arg :filter, :book_filter
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

  @desc "search filter for book author and title with partial match"
  input_object :book_filter do
    field :author, :string
    field :title, :string
  end

end
