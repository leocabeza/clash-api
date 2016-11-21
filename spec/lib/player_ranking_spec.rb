require_relative '../spec_helper.rb'

describe Clashinator::PlayerRanking do

  let(:player_rankings) do
    [
      Clashinator::PlayerRanking.new(
        'tag' => 'tag', 'name' => 'name',
        'expLevel' => 0, 'trophies' => 0,
        'attackWins' => 0, 'defenseWins' => 0,
        'rank' => 0, 'previousRank' => 0,
        'clan' => {}, 'league' => {}
      )
    ]
  end

  describe 'when Ranking class exists' do
    it 'must have a Base Class parent' do
      Clashinator::PlayerRanking.superclass.must_equal Clashinator::Base
    end

    it 'must have default attributes' do
      player_rankings.must_be_instance_of Array
      player_rankings.length.wont_equal 0
      player_rankings.first.must_be_instance_of Clashinator::PlayerRanking
      player_rankings.first.must_respond_to 'tag'
      player_rankings.first.must_respond_to 'name'
      player_rankings.first.must_respond_to 'exp_level'
      player_rankings.first.must_respond_to 'trophies'
      player_rankings.first.must_respond_to 'attack_wins'
      player_rankings.first.must_respond_to 'defense_wins'
      player_rankings.first.must_respond_to 'rank'
      player_rankings.first.must_respond_to 'previous_rank'
      player_rankings.first.must_respond_to 'clan'
      player_rankings.first.must_respond_to 'league'
    end
  end

  describe 'when a hash of urls are provided' do
    it 'must return correct values for instance methods' do
      player_rankings.first.tag.must_equal 'tag'
      player_rankings.first.name.must_equal 'name'
      player_rankings.first.exp_level.must_equal 0
      player_rankings.first.trophies.must_equal 0
      player_rankings.first.attack_wins.must_equal 0
      player_rankings.first.defense_wins.must_equal 0
      player_rankings.first.rank.must_equal 0
      player_rankings.first.previous_rank.must_equal 0
      player_rankings.first.clan.must_be_instance_of Clashinator::Clan
      player_rankings.first.league.must_be_instance_of Clashinator::League
    end
  end
end
