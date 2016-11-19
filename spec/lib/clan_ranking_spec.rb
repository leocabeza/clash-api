require_relative '../spec_helper.rb'

# TODO: These unit tests shouldn't be attached to other classes

describe Clashinator::ClanRanking do

  let(:ranking) do
    Clashinator::Location.location_clan_rankings('32000254', limit: 2)
  end

  describe 'when ClanRanking class exists' do
    it 'must have a Base Class parent' do
      Clashinator::ClanRanking.superclass.must_equal Clashinator::Base
    end

    it 'must have default attributes in at least one element' do
      ranking.must_be_instance_of Array
      ranking.length.wont_equal 0
      ranking.first.must_be_instance_of Clashinator::ClanRanking
      ranking.first.must_respond_to 'tag'
      ranking.first.must_respond_to 'name'
      ranking.first.must_respond_to 'clan_level'
      ranking.first.must_respond_to 'members'
      ranking.first.must_respond_to 'clan_points'
      ranking.first.must_respond_to 'rank'
      ranking.first.must_respond_to 'previous_rank'
      ranking.first.must_respond_to 'location'
      ranking.first.must_respond_to 'badge_urls'
    end
  end

  describe 'when a hash of urls are provided' do
    it 'must return object hash attributes as objects' do
      ranking.first.location.must_be_instance_of Clashinator::Location
      ranking.first.badge_urls.must_be_instance_of Clashinator::BadgeUrl
    end
  end
end
