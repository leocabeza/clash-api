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

    it 'must have a constant named CONFIG and also it must be a Hash' do
      Clashinator::Base::CONFIG.must_be_instance_of Hash
    end

    it 'must have a class variable named http_default_options' \
      ' and also it must be a Hash' do
      Clashinator::Base.http_default_options.must_be_instance_of Hash
    end

    it 'must have a header and authorization key in http_default_options' do
      Clashinator::Base.http_default_options
                       .key?(:headers).must_equal true
      Clashinator::Base.http_default_options[:headers]
                       .key?('Authorization').must_equal true
    end

    it 'must respond to class method prepare_query_options' do
      Clashinator::Base.must_respond_to 'prepare_query_options'
    end

    it 'must return sanitized query options in prepare_query_options' do
      options = Clashinator::Base.prepare_query_options(
        name: 'Vzlan Warriors', limit: 1
      )

      options.must_be_instance_of Hash
      options.key?(:query).must_equal true
      options[:query].key?(:name).must_equal true
      options[:query][:name].must_equal 'Vzlan Warriors'
    end
  end
end
