require_relative '../spec_helper'

describe Clashinator::Base do
  describe 'when Base class exists' do
    it 'must include httparty methods' do
      Clashinator::Base.must_include HTTParty
    end

    it 'must include underscorable module' do
      Clashinator::Base.must_include Underscorable
    end

    it 'must extend camelizable module' do
      Clashinator::Base.must_respond_to 'to_camel_case'
    end

    it 'must include correct base url' do
      Clashinator::Base.base_uri.must_equal 'https://api.clashofclans.com'
    end

    it 'must have a constant named CONFIG and also it must be a Hash' do
      Clashinator::Base::CONFIG.must_be_instance_of Hash
    end

    it 'must respond to as_array_of' do
      Clashinator::Base.must_respond_to 'as_array_of'
    end

    it 'must have a class variable named http_default_options' \
      ' and also it must be a Hash' do
      Clashinator::Base.http_default_options.must_be_instance_of Hash
    end

    it 'must have a header and authorization key in http_default_options' do
      Clashinator::Base.http_default_options
                       .key?(:headers).must_equal true
      Clashinator::Base.http_default_options[:headers]
                       .key?('Authorization').must_equal true
    end
  end

  describe 'when an_array_of class method is defined' do
    it 'must return a clan instance when clan model is provided' do
      clans = Clashinator::Base.as_array_of(Clashinator::Clan, [{}])
      clans.must_be_instance_of Array
      clans.first.must_be_instance_of Clashinator::Clan
    end

    it 'must return a league instance when league model is provided' do
      leagues = Clashinator::Base.as_array_of(Clashinator::League, [{}])
      leagues.must_be_instance_of Array
      leagues.first.must_be_instance_of Clashinator::League
    end

    it 'must return a location instance when location model is provided' do
      locations = Clashinator::Base.as_array_of(Clashinator::Location, [{}])
      locations.must_be_instance_of Array
      locations.first.must_be_instance_of Clashinator::Location
    end

    it 'must return a badge_url instance when badge_urls model is provided' do
      badge_urls = Clashinator::Base.as_array_of(Clashinator::BadgeUrl, [{}])
      badge_urls.must_be_instance_of Array
      badge_urls.first.must_be_instance_of Clashinator::BadgeUrl
    end

    it 'must return a player ranking instance when ' \
      'player ranking model is provided' do
      player_rankings = Clashinator::Base.as_array_of(
        Clashinator::PlayerRanking, [{}]
      )
      player_rankings.must_be_instance_of Array
      player_rankings.first.must_be_instance_of Clashinator::PlayerRanking
    end

    it 'must return a clan ranking instance when ' \
      'clan ranking model is provided' do
      clan_rankings = Clashinator::Base.as_array_of(
        Clashinator::ClanRanking, [{}]
      )
      clan_rankings.must_be_instance_of Array
      clan_rankings.first.must_be_instance_of Clashinator::ClanRanking
    end

    it 'must return a warlog instance when warlog model is provided' do
      warlogs = Clashinator::Base.as_array_of(Clashinator::Warlog, [{}])
      warlogs.must_be_instance_of Array
      warlogs.first.must_be_instance_of Clashinator::Warlog
    end

    it 'must return a season instance when season model is provided' do
      seasons = Clashinator::Base.as_array_of(Clashinator::Season, [{}])
      seasons.must_be_instance_of Array
      seasons.first.must_be_instance_of Clashinator::Season
    end

    it 'must return a player instance when player model is provided' do
      players = Clashinator::Base.as_array_of(Clashinator::Player, [{}])
      players.must_be_instance_of Array
      players.first.must_be_instance_of Clashinator::Player
    end

    it 'must return a achievement instance when ' \
      'achievement model is provided' do
      achievements = Clashinator::Base.as_array_of(
        Clashinator::Achievement, [{}]
      )
      achievements.must_be_instance_of Array
      achievements.first.must_be_instance_of Clashinator::Achievement
    end

    it 'must return a troop instance when ' \
      'troop model is provided' do
      troops = Clashinator::Base.as_array_of(
        Clashinator::Troop, [{}]
      )
      troops.must_be_instance_of Array
      troops.first.must_be_instance_of Clashinator::Troop
    end

    it 'must return a hero instance when ' \
      'hero model is provided' do
      heroes = Clashinator::Base.as_array_of(
        Clashinator::Hero, [{}]
      )
      heroes.must_be_instance_of Array
      heroes.first.must_be_instance_of Clashinator::Hero
    end

    it 'must return a spell instance when ' \
      'spell model is provided' do
      spells = Clashinator::Base.as_array_of(
        Clashinator::Spell, [{}]
      )
      spells.must_be_instance_of Array
      spells.first.must_be_instance_of Clashinator::Spell
    end
  end
end
