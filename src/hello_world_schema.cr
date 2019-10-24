require "graphql-crystal"

module Kemal::GraphQL
  module RootQuery
    include ::GraphQL::ObjectType
    extend self
    field "hello" { "world" }
  end

  HELLO_WORLD_SCHEMA = ::GraphQL::Schema.from_schema(
    %{
      schema {
        query: RootQuery
      }

      type RootQuery {
        hello: String
      }
    }
  )
  HELLO_WORLD_SCHEMA.query_resolver = RootQuery
end
