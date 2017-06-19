require "kemal"
require "json"
require "./schema"
require "./hello_world_schema"

module Kemal::GraphQL

  private def self.extract_graphql_payload(type : Symbol, env)
    case type
    when :query
      query_string = env.params.query["query"]
      query_params = env.params.query.has_key?("variables") ?
                       JSON.parse(env.params.query["variables"]).as_h : nil
    when :json
      payload = env.params.json
      query_string = payload["query"].as(String)
      query_params = payload["variables"]?.as Hash(String, JSON::Type)?
    end
    raise "no query provided!" unless query_string
    { query_string, query_params }
  end

  #
  # read query and variables from the request uri
  #
  get "/api_query" do |env|
    env.response.content_type = "application/json"
    Kemal::GraphQL::SCHEMA.execute(
      *extract_graphql_payload(:query, env)
    ).to_json
  end

  #
  # read query and variable from the json request body
  #
  post "/graphql" do |env|
    env.response.content_type = "application/json"
    Kemal::GraphQL::SCHEMA.execute(
      *extract_graphql_payload(:json, env)
    ).to_json
  end

  Kemal.config do
    host_binding = "0.0.0.0"
  end

  Kemal.run
end
