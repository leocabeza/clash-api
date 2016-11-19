require_relative '../spec_helper.rb'

describe Clashinator::Hero do

  let(:hero) do
    Clashinator::Hero.new(
      'name' => 'Barbarian King', 'level' => 35,
      'maxLevel' => 40
    )
  end

  describe 'when a hash of urls are provided' do
    it 'must have Army as a parent class' do
      Clashinator::Hero
        .superclass.must_equal Clashinator::Army
    end

    it 'must respond to default attributes' do
      hero.must_respond_to 'name'
      hero.must_respond_to 'level'
      hero.must_respond_to 'max_level'
    end

    it 'must have constructor values' do
      hero.name.must_equal 'Barbarian King'
      hero.level.must_equal 35
      hero.max_level.must_equal 40
    end
  end
end
