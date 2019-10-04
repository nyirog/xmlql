defmodule XmlqlWeb.Resolvers.BookStore do
  @moduledoc """
  Book store resolvers
  """

  alias Xmlql.Repo

  def list_books(_, %{filter: filters}, _) do
    {:ok, Repo.filter(filters)}
  end

  def list_books(_, _, _) do
    {:ok, Repo.list()}
  end

  def create_book(_, %{book: book}, _) do
    {:ok, Repo.create(book)}
  end

end
