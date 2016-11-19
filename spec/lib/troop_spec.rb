require_relative '../spec_helper.rb'

describe Clashinator::Troop do

  let(:troop) do
    Clashinator::Troop.new(
      'name' => 'Barbarian', 'level' => 6,
      'maxLevel' => 7
    )
  end

  describe 'when a hash of urls are provided' do
    it 'must have Army as a parent class' do
      Clashinator::Troop
        .superclass.must_equal Clashinator::Army
    end

    it 'must respond to default attributes' do
      troop.must_respond_to 'name'
      troop.must_respond_to 'level'
      troop.must_respond_to 'max_level'
    end

    it 'must return correct values of instance methods' do
      troop.name.must_equal 'Barbarian'
      troop.level.must_equal 6
      troop.max_level.must_equal 7
    end
  end
end
