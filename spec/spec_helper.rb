require_relative '../lib/clashinator'

require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/clan_cassettes'
  c.hook_into :webmock
end