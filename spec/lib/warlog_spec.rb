require_relative '../spec_helper.rb'

# TODO: These unit tests shouldn't be attached to other classes

describe Clashinator::Warlog do

  let(:warlog) { Clashinator::Clan.clan_war_log('#82JJP9PC', limit: 2) }

  describe 'when Warlog class exists' do
    it 'must have default attributes' do
      warlog.length.wont_equal 0
      warlog.first.must_respond_to 'clan'
      warlog.last.must_respond_to 'opponent'
      warlog.first.must_respond_to 'result'
      warlog.first.must_respond_to 'end_time'
      warlog.first.must_respond_to 'team_size'
      warlog.last.must_respond_to 'result'
      warlog.last.must_respond_to 'end_time'
      warlog.last.must_respond_to 'team_size'
    end
  end

  describe 'when a hash of urls are provided' do
    it 'must return an Array of warlog instances' do
      warlog.must_be_instance_of Array
      warlog.first.must_be_instance_of Clashinator::Warlog
    end

    it 'must return object hash attributes as clan objects' do
      warlog.first.clan.must_be_instance_of Clashinator::Clan
      warlog.last.opponent.must_be_instance_of Clashinator::Clan
    end
  end
end
