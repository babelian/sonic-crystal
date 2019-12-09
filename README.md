# sonic-crystal

[![Build Status](https://www.travis-ci.com/babelian/sonic-crystal.svg?branch=master)](https://www.travis-ci.com/babelian/sonic-crystal)

A Crystal client for [Sonic search backend](https://github.com/valeriansaliou/sonic).

This is my first project writing crystal, and is a port of
[sonic-ruby](https://github.com/atipugin/sonic-ruby). This took about 4 hours, and went fairly smoothly. I've pegged the version to `sonic-ruby`, so if development continues it will be in lock step.

## Ruby to Crystal Port Notes

* I've commented with `#cr` for crystal specific modifications or `#rb` for examples of how it was originally implemented.
* RSpec `include_context` and `include_examples` replaced with macros
* `Sonic::Connection#socket` uses `TCPSocket#open` rather than `TCPSocket#open`
* Replaced `String#starts_with?('X ')` with `=~ /^X /`.
* `Sonic::Channels::Base` required all sub class methods to be defined so there's a block in `base.cr` there with empty method definitions.
* Most messages passed to `Sonic::Channels::Base#execute` use a `arr.join(" ")` rather than `*arr` due to issues with variable sized Tuples.

## Installation

Add following line to your `shard.yml`:

```yaml
dependencies:
  migrate:
    github: babelian/sonic-crystal.cr
    version: ~> 0.22.0
```

And then execute:

```shell
$ shards install
```

## Development

```shell
$ docker-compose run app guardian
```

<!-- below copied from sonic-ruby: -->

## Usage (copied from `sonic-ruby`)

Start with creating new client:

```ruby
client = Sonic::Client.new('localhost', 1491, 'SecretPassword')
```

Now you can use `#channel` method in order to connect to specific channels:

```ruby
control = client.channel(:control)
ingest = client.channel(:ingest)
search = client.channel(:search)
```

[Learn more about Sonic Channels](https://github.com/valeriansaliou/sonic/blob/master/PROTOCOL.md).

## Indexing

```ruby
# Init `ingest` channel
ingest = client.channel(:ingest)

# Add data to index
ingest.push('users', 'all', 1, 'Alexander Tipugin')
# => true

# Remove data from index
ingest.pop('users', 'all', 1, 'Alexander Tipugin')
# => 2

# Count collection/bucket/object items
ingest.count('users', 'all', 1)
# => 1

# Flush entire collection
ingest.flushc('users')
# => 1

# Flush entire bucket inside collection
ingest.flushb('users', 'all')
# => 1

# Flush specific object inside bucket
ingest.flusho('users', 'all', 1)
# => 2
```

## Searching

```ruby
# Init `search` channel
search = client.channel(:search)

# Find indexed object by term
search.query('users', 'all', 'tipugin')
# => 1

# Auto-complete word
search.suggest('users', 'all', 'alex')
# => alexander
```