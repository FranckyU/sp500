# Sp500

Welcome to sp500, you'll find this gem useful for exploring the S&P 500 stock list.

## Features

- List all the 505 stocks. The API for that is `Sp500.list`
- List SECTORS and INDUSTRIES => `Sp500.sectors`, `Sp500.industries`
- Group stocks by GICS SECTOR or INDUSTRY => `Sp500.by_sectors`, `Sp500.by_industries`

To experiment with these features, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sp500'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sp500

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/FranckyU/sp500. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sp500 project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/FranckyU/sp500/blob/master/CODE_OF_CONDUCT.md).
