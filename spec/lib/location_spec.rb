require_relative '../spec_helper.rb'

describe Clashinator::Location do
  describe 'when Location class exists' do
    it 'must have a Base Class parent' do
      Clashinator::Location.superclass.must_equal Clashinator::Base
    end
  end

  describe 'when list_locations class method exists' do

    let(:locations) do
      Clashinator::Location.list_locations(
        connection, limit: 1
      )
    end

    it 'must include a class method named list_locations' do
      Clashinator::Location.must_respond_to 'list_locations'
    end

    it 'must have default attributes' do
      locations.must_be_instance_of Clashinator::ArrayResource
      locations.items.first.must_be_instance_of Clashinator::Location
      locations.items.first.must_respond_to 'id'
      locations.items.first.must_respond_to 'name'
      locations.items.first.must_respond_to 'is_country'
    end

    it 'must return correct values for instance methods' do
      locations.items.first.id.must_equal 32_000_000
      locations.items.first.name.must_equal 'Europe'
      locations.items.first.is_country.must_equal false
    end

    it 'must raise an error when wrong paging params are given' do
      lambda do
        Clashinator::Location.list_locations(
          connection,
          limit: 1, after: '2938383838'
        )
      end.must_raise RuntimeError
    end
  end

  describe 'when location_info class method exists' do

    let(:country_location) do
      Clashinator::Location.location_info(
        connection, '32000254'
      )
    end
    let(:continent_location) do
      Clashinator::Location.location_info(
        connection, '32000002'
      )
    end

    it 'must include a class method named location_info' do
      Clashinator::Location.must_respond_to 'location_info'
    end

    it 'must return an instance of location when it is a country' do
      country_location.must_be_instance_of Clashinator::Location
      country_location.must_respond_to 'id'
      country_location.must_respond_to 'name'
      country_location.must_respond_to 'is_country'
      country_location.must_respond_to 'country_code'
    end

    it 'must return correct values for instance methods ' \
      'when it is a country' do
      country_location.id.must_equal 32_000_254
      country_location.name.must_equal 'Venezuela'
      country_location.is_country.must_equal true
      country_location.country_code.must_equal 'VE'
    end

    it 'must return an instance of location when it is a continent' do
      continent_location.must_be_instance_of Clashinator::Location
      continent_location.must_respond_to 'id'
      continent_location.must_respond_to 'name'
      continent_location.must_respond_to 'is_country'
    end

    it 'must return correct values for instance methods ' \
      'when it is a continent' do
      continent_location.id.must_equal 32_000_002
      continent_location.name.must_equal 'South America'
      continent_location.is_country.must_equal false
    end

    it 'must raise an error when wrong location_id is provided' do
      lambda do
        Clashinator::Location.location_info(
          connection, '2222222222222'
        )
      end.must_raise RuntimeError
    end
  end

  describe 'when location_clan_rankings class method exists' do

    it 'must include a class method named location_clan_rankings' do
      Clashinator::Location.must_respond_to 'location_clan_rankings'
    end

    it 'must raise an error when wrong location_id is provided' do
      lambda do
        Clashinator::Location.location_clan_rankings(
          connection, '2222222222222'
        )
      end.must_raise RuntimeError
    end

    it 'must return an ArrayResource of ranking instances' do
      clan_rankings = Clashinator::Location.location_clan_rankings(
        connection,
        '32000254', limit: 1
      )
      clan_rankings.must_be_instance_of Clashinator::ArrayResource
      clan_rankings.items.first.must_be_instance_of Clashinator::ClanRanking
    end

    it 'must raise an error when wrong paging params are given' do
      lambda do
        Clashinator::Location.location_clan_rankings(
          connection,
          '32000254',
          limit: 1, after: '2938383838'
        )
      end.must_raise RuntimeError
    end
  end

  describe 'when location_player_rankings class method exists' do
    it 'must include a class method named location_clan_rankings' do
      Clashinator::Location.must_respond_to 'location_player_rankings'
    end

    it 'must return an ArrayResource of PlayerRanking instances' do
      rankings = Clashinator::Location.location_player_rankings(
        connection,
        '32000254', limit: 1
      )
      rankings.must_be_instance_of Clashinator::ArrayResource
      rankings.items.first.must_be_instance_of Clashinator::PlayerRanking
    end

    it 'must raise an error when wrong paging params are given' do
      lambda do
        Clashinator::Location.location_player_rankings(
          connection,
          '32000254',
          limit: 1, after: '2938383838'
        )
      end.must_raise RuntimeError
    end

    it 'must raise an error when wrong location_id is provided' do
      lambda do
        Clashinator::Location.location_player_rankings(
          connection, '2222222222222'
        )
      end.must_raise RuntimeError
    end
  end
end
