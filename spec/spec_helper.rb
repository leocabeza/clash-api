require_relative '../lib/clashinator'

require 'minitest/autorun'

def config
  YAML.load_file('config/secrets.yml')
end
# TODO: use webmock for all tests
# require 'webmock/minitest'
# require 'vcr'

# VCR.configure do |c|
#   c.cassette_library_dir = 'spec/fixtures/clash_cassettes'
#   c.hook_into :webmock
# end
