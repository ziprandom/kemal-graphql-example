# kemal-graphql

Coupling of [kemal](https://github.com/kemalcr/kemal), [grapqhiql](https://github.com/graphql/graphiql) and [graphql-crystal](https://github.com/ziprandom/graphql-crystal).

## Installation

Clone the git repository, enter the repository directory and run :

```sh
shards
```

to install all the dependencies.

## Usage

build the project with

```sh
crystal build --release src/kemal-graphql.cr
```

and start the server with

```sh
./kemal-graphql
```

or run it directly with (use the release flag to see the best performance)

```sh
crystal run [--release] src/kemal-graphql.cr
```

now you can open up a browser and go to [http://localhost:3000/index.html](http://localhost:3000/index.html?query=%7B%0A%20%20posts%20%7B%0A%20%20%20%20title%0A%20%20%20%20author%20%7B%0A%20%20%20%20%20%20id%0A%20%20%20%20%20%20fullName%0A%20%20%20%20%7D%0A%20%20%7D%0A%7D) to explore the graphql schema.

## Development

run specs with

```sh
KEMAL_ENV=test crystal spec
```

## Contributing

1. Fork it ( https://github.com/ziprandom/kemal-graphql/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[ziprandom]](https://github.com/[zoiprandom])  - creator, maintainer
- [[Facebook GraphQL]](https://github.com/graphql) - creator of graphiql
