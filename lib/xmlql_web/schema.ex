defmodule XmlqlWeb.Schema do
  use Absinthe.Schema

  alias XmlqlWeb.Resolvers

  import Absinthe.Schema

  query do

    field :book_store, list_of(:book) do
      arg :filter, :book_filter
      resolve &Resolvers.BookStore.list_books/3
    end

  end

  subscription do
    field :new_book, :book do
      config fn _args, _info ->
        {:ok, topic: "*"}
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

  @desc "search filter for book author and title with partial match"
  input_object :book_filter do
    field :author, :string
    field :title, :string
  end

  mutation do

    field :create_book, :book do
      arg :book, :book_input
      resolve &Resolvers.BookStore.create_book/3
    end

  end

  @desc "book input"
  input_object :book_input do
    field :ISBN, non_null(:id), name: "isbn"
    field :author, non_null(:string)
    field :date, :string
    field :publisher, non_null(:string)
    field :title, non_null(:string)
  end

  def build(%Absinthe.Type.Object{} = schema) do
    schema
    |> Map.get(:fields)
    |> Enum.filter(fn {k, _} -> k not in [:__schema, :__type, :__typename] end)
    |> Enum.map(fn {k, v} -> {k, build(v)} end)
    |> Enum.into(%{})
  end

  def build(%Absinthe.Type.Field{} = schema) do
    schema
    |> Map.get(:type)
    |> build()
  end

  def build(%Absinthe.Type.List{} = schema) do
    list_type = schema
    |> Map.get(:of_type)
    |> build()
    {:list, list_type}
  end

  def build(%Absinthe.Type.Scalar{} = schema) do
    schema
    |> Map.get(:identifier)
  end

  def build(schema) when is_atom(schema) do
    lookup_type(__MODULE__, schema)
    |> build()
  end

end
