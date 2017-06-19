require "graphql-crystal"

module Kemal::GraphQL
  HELLO_WORLD_SCHEMA = ::GraphQL::Schema.from_schema(
    %{
      schema {
        query: RootQuery
      }

      type RootQuery {
        hello: String
      }
    }
  ).resolve do
    query "hello" { "world" }
  end
end
