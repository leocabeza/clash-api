require_relative '../spec_helper.rb'

# TODO: These unit tests shouldn't be attached to other classes

describe Clashinator::PlayerRanking do

  let(:ranking) do
    Clashinator::Location.location_player_rankings(
      '32000254', limit: 2
    )
  end

  describe 'when Ranking class exists' do
    it 'must have a Base Class parent' do
      Clashinator::PlayerRanking.superclass.must_equal Clashinator::Base
    end

    it 'must have default attributes in at least one element' do
      ranking.must_be_instance_of Array
      ranking.length.wont_equal 0
      ranking.first.must_be_instance_of Clashinator::PlayerRanking
      ranking.first.must_respond_to 'tag'
      ranking.first.must_respond_to 'name'
      ranking.first.must_respond_to 'exp_level'
      ranking.first.must_respond_to 'trophies'
      ranking.first.must_respond_to 'attack_wins'
      ranking.first.must_respond_to 'defense_wins'
      ranking.first.must_respond_to 'rank'
      ranking.first.must_respond_to 'previous_rank'
      ranking.first.must_respond_to 'clan'
      ranking.first.must_respond_to 'league'
    end
  end

  describe 'when a hash of urls are provided' do
    it 'must return object hash attributes as objects' do
      ranking.first.clan.must_be_instance_of Clashinator::Clan
      ranking.first.league.must_be_instance_of Clashinator::League
    end
  end
end
