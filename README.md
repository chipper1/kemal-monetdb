# kemal-monetdb

Kemal Data connnection layer for MonetDB

This is currently experimental.

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  kemal-monetdb:
    github: puppetpies/kemal-monetdb
```


## Usage


```crystal
require "kemal"
require "kemal-monetdb"

CONN_OPTS = {
  "host" => "127.0.0.1",
  "user" => "root",
  "password" => "",
  "db" => "your_db"
}

monetdb_connect CONN_OPTS

# Make sure to yield `env`.
get "/" do |env|
  env.content_type = "application/json"
  users = conn.query("SELECT * FROM users")
  # Release the connection after you are done with exec
  release
  # Renders the users as JSON
  users
end

```
## Development

TODO: Test / Implement the connection pool as in kemal-mysql

## Contributing

1. Fork it ( https://github.com/puppetpies/kemal-monetdb/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [puppetpies](https://github.com/puppetpies) Bri in The Sky - creator, maintainer
