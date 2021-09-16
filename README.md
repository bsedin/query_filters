# QueryFilters

Hello there! You can use this tiny library to parse pretty query strings to pretty hashes or arrays.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'query_filters'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install query_filters

## Usage

```ruby
QueryFilters.parse('date_gteq=20-11-2018,date_lteq=20-12-2018')
```

Produces:

```ruby
{ date_gteq: '20-11-2018', date_lteq: '20-12-2018' }
```

### Nested params

```ruby
QueryFilters.parse('date_gteq=20-11-2018,date_lteq=20-12-2018,posts:title=what about dogs,posts:order=date_desc')
```

Produces:

```ruby
{
  date_gteq: '20-11-2018',
  date_lteq: '20-12-2018',
  posts: { title: 'what about dogs', order: 'date_desc' }
}
```

### Configuration

You can configure parser through options:

```ruby
QueryFilters.parse('posts/title:what about dogs;posts/order:title_desc',
  nesting_separator: '/',
  assignment_separator: ':',
  filters_separator: ';',
  symbolize_keys: false
)
```

Produces:

```ruby
{"posts"=>{"title"=>"what about dogs", "order"=>"title_desc"}}
```

Default options are:

* nesting_separator `:`
* assignment_separator `=`
* filters_separator `,`
* symbolize_keys `true`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kressh/query_filters.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
