require "spec-kemal"
require "benchmark"
require "../src/kemal-graphql.cr"

payload = {
  "payload" => {
    "postId" => Kemal::GraphQL::POSTS.last.id,
    "body" => "would be the most wonderful thing",
    "authorId" => Kemal::GraphQL::USERS[1].id
  }
}.to_json

query_string = <<-query
      mutation CreateComment($payload: CommentInput) {
        comment(payload: $payload) {
          author { first_name }
          body
        }
      }
    query

puts JSON.parse(
       get(
         "/schema?query=#{query_string}", nil, payload
       ).body
     ).to_pretty_json
