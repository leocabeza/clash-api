require_relative '../spec_helper'

describe Clashinator::Base do
  describe 'when Base class exists' do
    it 'must include httparty methods' do
      Clashinator::Base.must_include HTTParty
    end

    it 'must include underscorable module' do
      Clashinator::Base.must_include Underscorable
    end

    it 'must extend camelizable module' do
      Clashinator::Base.must_respond_to 'to_camel_case'
    end

    it 'must include correct base url' do
      Clashinator::Base.base_uri.must_equal 'https://api.clashofclans.com'
    end

    it 'must respond to class method prepare_options' do
      Clashinator::Base.must_respond_to 'prepare_options'
    end

    it 'must return correct value for prepare_options' do
      options = Clashinator::Base.prepare_options('token', clan_tag: '#VQ2QUJG')
      options.key?(:headers).must_equal true
      options[:headers].key?('Authorization').must_equal true
      options[:headers]['Authorization'].must_equal 'Bearer token'
      options.key?(:query).must_equal true
      options[:query].key?(:clanTag).must_equal true
      options[:query][:clanTag].must_equal '%23VQ2QUJG'
    end
  end
end
