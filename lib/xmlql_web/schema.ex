defmodule XmlqlWeb.Schema do
  use Absinthe.Schema

  query do

    field :book_store, list_of(:book) do
      resolve fn _, _, _ ->
        {:ok, Xmlql.Repo.list()}
      end
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
