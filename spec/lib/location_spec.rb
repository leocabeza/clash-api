require_relative '../spec_helper.rb'

describe Clashinator::Location do
  describe 'when Location class exists' do
    it 'must have a Base Class parent' do
      Clashinator::Location.superclass.must_equal Clashinator::Base
    end
  end

  describe 'when list_locations class method exists' do
    it 'must include a class method named list_locations' do
      Clashinator::Location.must_respond_to 'list_locations'
    end

    it 'must return an array of location instances' do
      locations = Clashinator::Location.list_locations(limit: 2)
      locations.must_be_instance_of Array
      locations.first.must_be_instance_of Clashinator::Location
      locations.first.must_respond_to 'id'
      locations.first.must_respond_to 'name'
      locations.first.must_respond_to 'is_country'
    end
  end

  describe 'when location_info class method exists' do
    it 'must include a class method named location_info' do
      Clashinator::Location.must_respond_to 'location_info'
    end

    it 'must return an instance of location when it is a country' do
      location = Clashinator::Location.location_info('32000254')
      location.must_be_instance_of Clashinator::Location
      location.must_respond_to 'id'
      location.must_respond_to 'name'
      location.must_respond_to 'is_country'
      location.must_respond_to 'country_code'
    end

    it 'must return an instance of location when it is a continent' do
      location = Clashinator::Location.location_info('32000002')
      location.must_be_instance_of Clashinator::Location
      location.must_respond_to 'id'
      location.must_respond_to 'name'
      location.must_respond_to 'is_country'
    end

    it 'must raise an error when wrong location_id is provided' do
      -> { Clashinator::Location.location_info('2222222222222') }
        .must_raise RuntimeError
    end
  end

  describe 'when location_clan_rankings class method exists' do
    it 'must include a class method named location_clan_rankings' do
      Clashinator::Location.must_respond_to 'location_clan_rankings'
    end

    it 'must raise an error when wrong location_id is provided' do
      -> { Clashinator::Location.location_clan_rankings('2222222222222') }
        .must_raise RuntimeError
    end

    it 'must return an array of ranking instances' do
      rankings = Clashinator::Location.location_clan_rankings('32000254', limit: 2)
      rankings.must_be_instance_of Array
      rankings.first.must_be_instance_of Clashinator::ClanRanking
    end
  end

  describe 'when location_player_rankings class method exists' do
    it 'must include a class method named location_clan_rankings' do
      Clashinator::Location.must_respond_to 'location_player_rankings'
    end

    it 'must raise an error when wrong location_id is provided' do
      -> { Clashinator::Location.location_player_rankings('2222222222222') }
        .must_raise RuntimeError
    end

    it 'must return an array of PlayerRanking instances' do
      rankings = Clashinator::Location.location_player_rankings('32000254', limit: 2)
      rankings.must_be_instance_of Array
      # rankings.first.must_be_instance_of Clashinator::PlayerRanking
    end
  end
end
