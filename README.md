# Clashinator

Ruby wrapper for the Clash of Clans API, based on the v1 version

Note: These docs were updated for the new tagged version 1.0

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

All query options can be passed as underscored variables instead of
camelcased, query options available are at: [https://developer.clashofclans.com](https://developer.clashofclans.com)

There are several types of objects you can retrieve:

```ruby
clans = client.search_clans(name: 'vzlan warriors', min_members: 25)

clan = client.clan_info('#VQ2QUJG')

players = client.list_clan_members('#VQ2QUJG')

war_log = client.clan_war_log('#VQ2QUJG')

locations = client.list_locations

location = client.location_info(32000254)

clan_rankings = client.location_clan_rankings(32000254)

player_rankings = client.location_player_rankings(32000254)

leagues = client.list_leagues

league = client.league_info(29000022)

seasons = client.league_seasons(29000022)

player_rankings = client.league_season_rankings(29000022, '2015-10')

player = client.player_info('#QOCRLV90')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Create a new file called `secrets.yml` in the config folder with the contents of `config/secrets.sample.yml`
Then, you'll need to generate an access token in Clash of Clans developer page at:
[https://developer.clashofclans.com](https://developer.clashofclans.com)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/leocabeza/clash-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
Remember to add a test for each new feature you add, and before submitting a pull request, check that all tests are passing by running: `rake`

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

