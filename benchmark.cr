require "benchmark"
require "./src/go_graphql_test_schema.cr"

puts "running the query once to make sure the server works:"
query = %{
  query Example($size: Int) {
    a,
    b,
    x: c
    ...c
    f
    ...on DataType {
      pic(size: $size)
      promise {
	a
      }
    }
    deep {
      a
      b
      c
      deeper {
	a
	b
      }
    }
  }
  fragment c on DataType {
    d
    e
  }
}

puts Kemal::GraphQL::GO_GRAPHQL_TEST_SCHEMA.execute(query, {"size" => 50}).to_pretty_json

Benchmark.ips do |x|
  x.report("running go_graphqls benchmark schema") do
    query = %{
      query Example($size: Int) {
	a,
	b,
	x: c
	...c
	f
	...on DataType {
	  pic(size: $size)
	  promise {
	    a
	  }
	}
	deep {
	  a
	  b
	  c
	  deeper {
	    a
	    b
	  }
	}
      }
      fragment c on DataType {
	d
	e
      }
    }

    Kemal::GraphQL::GO_GRAPHQL_TEST_SCHEMA.execute(query, {"size" => 50})
  end
end
