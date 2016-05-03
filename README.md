# Clashinator

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/clashinator`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'clashinator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clashinator

## Usage

You'll need to generate an access token in Clash of Clans developer page at:
[https://developer.clashofclans.com](https://developer.clashofclans.com)

With your access token, retrieve a client instance with it.

`client = Clashinator::Client.new('YOUR TOKEN')`

To retrieve objects(for now JSON data), you can perform this actions, defined in the Clash of Clans API docs:

```ruby
client.find_clan({name: 'onehive', minMembers: 25})

client.get_clan_info({clan_tag: '#2U2CYPQ8'})

client.list_clan_members({clan_tag: '#2U2CYPQ8'})

client.list_locations()

client.get_location_info({location_id: 32000254})

client.get_ranking_for_location({location_id: 32000254, ranking_id: 'clans'})
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/leocabeza/clashinator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

