require_relative '../spec_helper.rb'

describe Clashinator::Army do

  let(:army) do
    Clashinator::Army.new(
      'name' => 'Barbarian', 'level' => 6,
      'maxLevel' => 7
    )
  end

  describe 'when a hash of urls are provided' do
    it 'must respond to default attributes' do
      army.must_respond_to 'name'
      army.must_respond_to 'level'
      army.must_respond_to 'max_level'
    end

    it 'must return correct values of instance methods' do
      army.name.must_equal 'Barbarian'
      army.level.must_equal 6
      army.max_level.must_equal 7
    end
  end
end
