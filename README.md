# Xmlql

To start your graphql server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000/graphiql`](http://localhost:4000/graphiql) from your browser.

Xmlql is learning project to add graphql interface to an xml document.
Xmlql uses the data binder interface of [erlsom](https://github.com/willemdj/erlsom)
for xml parsing. The xml document is borrowed from the
[bookstore](https://github.com/willemdj/erlsom/tree/master/examples/book_store)
example of erlsom.

# ToDo

The xml loading to Elixir map is almost automatic, but the graphql schema is
hardcoded. It would be better to generate xsd from graphql schema and hrl from
the xsd.
