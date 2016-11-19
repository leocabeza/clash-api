require_relative '../spec_helper.rb'

describe Clashinator::Achievement do

  let(:achievement) do
    Clashinator::Achievement.new(
      'name' => 'Bigger Coffers', 'stars' => 3, 'value' => 11,
      'target' => 10, 'info' => 'Upgrade a Gold Storage to level 10',
      'completion_info' => 'Highest Gold Storage level: 11'
    )
  end

  describe 'when Achievement class exists' do
  end

  describe 'when the class is instantiated' do
    it 'must respond to default attributes' do
      achievement.must_respond_to 'name'
      achievement.must_respond_to 'stars'
      achievement.must_respond_to 'value'
      achievement.must_respond_to 'target'
      achievement.must_respond_to 'info'
      achievement.must_respond_to 'completion_info'
    end

    it 'must have constructor values' do
      achievement.name.must_equal 'Bigger Coffers'
      achievement.stars.must_equal 3
      achievement.value.must_equal 11
      achievement.target.must_equal 10
      achievement.info.must_equal 'Upgrade a Gold Storage to level 10'
      achievement.completion_info.must_equal 'Highest Gold Storage level: 11'
    end
  end
end
