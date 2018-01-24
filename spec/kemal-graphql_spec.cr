require "spec-kemal"
require "./spec_helper"
require "benchmark"

describe Kemal::GraphQL do

  payload = {
    "payload" => {
      "postId" => Kemal::GraphQL::POSTS.last.id,
      "body" => "would be the most wonderful thing",
      "authorId" => Kemal::GraphQL::USERS[1].id
    }
  }

  query_string = <<-query
      mutation CreateComment($payload: CommentInput) {
        comment(payload: $payload) {
          body
        }
      }
    query

  it "serves the schema on query params" do
    get("/api_query?query=#{URI.escape(query_string)}&variables=#{URI.escape(payload.to_json)}", nil)
    response.body.should eq "{\"data\":{\"comment\":{\"body\":\"would be the most wonderful thing\"}}}"
  end

  it "serves the schema on json params" do
    body = {"query" => query_string, "variables" => payload}.to_json
    post("/graphql", headers: HTTP::Headers{"Content-Type" => "application/json"}, body: body)
    response.body.should eq "{\"data\":{\"comment\":{\"body\":\"would be the most wonderful thing\"}}}"
  end

  it "passes the username header down to the callback" do
    body = {"query" => query_string, "variables" => payload}.to_json
    post("/graphql", headers: HTTP::Headers{"Content-Type" => "application/json", "USERNAME" => "tom"}, body: body)
    response.body.should eq "{\"data\":{\"comment\":{\"body\":\"would be the most wonderful thing\"}}}"

    post("/graphql", headers: HTTP::Headers{"Content-Type" => "application/json", "USERNAME" => "ada"}, body: body)
    response.body.should eq "{\"data\":{\"comment\":{\"body\":\"would be the most wonderful thing\"}}}"

  end
end
