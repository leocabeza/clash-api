require_relative '../lib/clashinator'

require 'minitest/autorun'
require 'yaml'
require 'faraday'

def secrets
  YAML.load_file('config/secrets.yml')
end

def connection
  Faraday.new(
    url: 'https://api.clashofclans.com',
    headers: {
      'Authorization' => "Bearer #{secrets['token_test']}"
    }
  )
end
# TODO: use webmock for all tests
# require 'webmock/minitest'
# require 'vcr'

# VCR.configure do |c|
#   c.cassette_library_dir = 'spec/fixtures/clash_cassettes'
#   c.hook_into :webmock
# end
