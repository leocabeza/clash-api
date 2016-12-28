require_relative '../spec_helper'

describe Clashinator::Base do
  describe 'when Base class exists' do
    it 'must include underscorable module' do
      Clashinator::Base.must_include Underscorable
    end

    it 'must extend camelizable module' do
      Clashinator::Base.must_respond_to 'to_camel_case'
    end

    it 'must respond to class method prepare_options' do
      Clashinator::Base.must_respond_to 'prepare_options'
    end

    it 'must return correct value for prepare_options' do
      options = Clashinator::Base.prepare_options(clan_tag: '#VQ2QUJG')
      options.key?(:clanTag).must_equal true
      options[:clanTag].must_equal '%23VQ2QUJG'
    end
  end
end
