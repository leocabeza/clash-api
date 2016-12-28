require_relative '../spec_helper.rb'

describe Clashinator::Client do

  let(:client) { Clashinator::Client.new(secrets['token_test']) }

  describe 'when a token string is provided' do
    it 'must respond to default attributes' do
      client.must_respond_to 'token'
      # clan class methods
      client.must_respond_to 'search_clans'
      client.must_respond_to 'clan_info'
      client.must_respond_to 'list_clan_members'
      client.must_respond_to 'clan_war_log'
      # location class methods
      client.must_respond_to 'list_locations'
      client.must_respond_to 'location_info'
      client.must_respond_to 'location_clan_rankings'
      client.must_respond_to 'location_player_rankings'
      # league class methods
      client.must_respond_to 'list_leagues'
      client.must_respond_to 'league_info'
      client.must_respond_to 'league_seasons'
      client.must_respond_to 'league_season_rankings'
      # player class methods
      client.must_respond_to 'player_info'
    end

    it 'must return correct values of instance methods' do
      client.uri.must_equal config['url']
      client.must_respond_to 'headers'
      client.headers.must_be_instance_of Hash
      client.headers.key?('Authorization').must_equal true
      client.headers['Authorization'].must_equal "Bearer #{secrets['token_test']}"
    end
  end

  describe 'when no token string is provided' do
    it 'must raise an error' do
      -> { Clashinator::Client.new }.must_raise ArgumentError
    end
  end
end
