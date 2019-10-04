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

end
