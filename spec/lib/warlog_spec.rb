require_relative '../spec_helper.rb'

describe Clashinator::Warlog do

  let(:warlogs) do
    [
      Clashinator::Warlog.new(
        'clan' => {}, 'opponent' => {},
        'result' => 'win', 'endTime' => '20161120T004221.000Z',
        'teamSize' => 10
      )
    ]
  end

  describe 'when Warlog class exists' do
    it 'must have a Base Class parent' do
      Clashinator::Warlog.superclass.must_equal Clashinator::Base
    end

    it 'must have default attributes' do
      warlogs.must_be_instance_of Array
      warlogs.length.wont_equal 0
      warlogs.first.must_be_instance_of Clashinator::Warlog
      warlogs.first.must_respond_to 'clan'
      warlogs.first.must_respond_to 'opponent'
      warlogs.first.must_respond_to 'result'
      warlogs.first.must_respond_to 'end_time'
      warlogs.first.must_respond_to 'team_size'
      warlogs.first.clan.must_be_instance_of Clashinator::Clan
      warlogs.first.opponent.must_be_instance_of Clashinator::Clan
    end
  end

  describe 'when a hash of urls are provided' do
    it 'must return correct values for instance methods' do
      warlogs.first.clan.must_be_instance_of Clashinator::Clan
      warlogs.first.opponent.must_be_instance_of Clashinator::Clan
      warlogs.first.result.must_equal 'win'
      warlogs.first.end_time.must_equal '20161120T004221.000Z'
      warlogs.first.team_size.must_equal 10
    end
  end
end
