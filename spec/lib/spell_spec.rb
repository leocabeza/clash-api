require_relative '../spec_helper.rb'

describe Clashinator::Spell do

  let(:spell) do
    Clashinator::Spell.new(
      'name' => 'Healing Spell',
      'level' => 6,
      'maxLevel' => 6
    )
  end

  describe 'when a hash of urls are provided' do
    it 'must have Army as a parent class' do
      Clashinator::Spell
        .superclass.must_equal Clashinator::Army
    end

    it 'must respond to default attributes' do
      spell.must_respond_to 'name'
      spell.must_respond_to 'level'
      spell.must_respond_to 'max_level'
    end

    it 'must have constructor values' do
      spell.name.must_equal 'Healing Spell'
      spell.level.must_equal 6
      spell.max_level.must_equal 6
    end
  end
end
