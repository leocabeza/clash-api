require_relative '../spec_helper.rb'

describe Clashinator::Season do
  describe 'when Ranking class exists' do
    it 'must have default attributes' do
      season = Clashinator::Season.new('2015-10')
      season.must_be_instance_of Clashinator::Season
      season.must_respond_to 'id'
      season.id.must_equal '2015-10'
    end
  end
end
