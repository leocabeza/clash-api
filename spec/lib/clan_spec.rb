require_relative '../spec_helper.rb'

describe Clashinator::Clan do

  let(:clan) { Clashinator::Clan.new('VQ2QUJG') }

  describe 'default attributes' do
    it 'must include httparty methods' do
      Clashinator::Clan.must_include HTTParty
    end

    it 'must have the base url set to the clash of clans API endpoint' do
      Clashinator::Clan.base_uri.must_equal 'https://api.clashofclans.com'
    end

    it 'must have a tag attribute' do
      clan.must_respond_to :tag
    end

    it 'must have a the right attribute' do
      clan.tag.must_equal '%23VQ2QUJG'
    end
  end

  describe 'GET clan information' do

    let(:clan) { Clashinator::Clan.new('VQ2QUJG') }

    before do
      VCR.insert_cassette 'clan', record: :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it 'must have a location method' do
      clan.must_respond_to :location
    end

    it 'must parse the api response from JSON to Hash' do
      clan.location.must_be_instance_of Hash
    end

    it 'must perform the request and get the data' do
      clan.location['name'].must_equal 'Vzlan Warriors'
    end

    it 'records the fixture' do
      token = '123456'
      Clashinator::Clan.get(
        '/v1/clans/%23VQ2QUJG',
        headers: {
          content_type: 'application/json',
          authorization: "Bearer #{token}"
        }
      )
    end

  end
end
