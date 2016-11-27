require_relative '../spec_helper.rb'

describe Clashinator::ClanRanking do

  let(:clan_ranking) do
    [
      Clashinator::ClanRanking.new(
        'tag' => 'tag', 'name' => 'name',
        'clanLevel' => 0, 'members' => 0,
        'clanPoints' => 0, 'rank' => 0,
        'previousRank' => 0, 'location' => {},
        'badgeUrls' => {}
      )
    ]
  end

  describe 'when ClanRanking class exists' do
    it 'must have a Base Class parent' do
      Clashinator::ClanRanking.superclass.must_equal Clashinator::Base
    end

    it 'must have default attributes' do
      clan_ranking.must_be_instance_of Array
      clan_ranking.length.wont_equal 0
      clan_ranking.first.must_be_instance_of Clashinator::ClanRanking
      clan_ranking.first.must_respond_to 'tag'
      clan_ranking.first.must_respond_to 'name'
      clan_ranking.first.must_respond_to 'clan_level'
      clan_ranking.first.must_respond_to 'members'
      clan_ranking.first.must_respond_to 'clan_points'
      clan_ranking.first.must_respond_to 'rank'
      clan_ranking.first.must_respond_to 'previous_rank'
      clan_ranking.first.must_respond_to 'location'
      clan_ranking.first.must_respond_to 'badge_urls'
    end
  end

  describe 'when a hash of urls are provided' do
    it 'must return correct values for instance methods' do
      clan_ranking.first.tag.must_equal 'tag'
      clan_ranking.first.name.must_equal 'name'
      clan_ranking.first.clan_level.must_equal 0
      clan_ranking.first.members.must_equal 0
      clan_ranking.first.clan_points.must_equal 0
      clan_ranking.first.rank.must_equal 0
      clan_ranking.first.previous_rank.must_equal 0
      clan_ranking.first.location.must_be_instance_of Clashinator::Location
      clan_ranking.first.badge_urls.must_be_instance_of Clashinator::BadgeUrl
    end
  end
end
