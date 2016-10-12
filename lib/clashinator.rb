require 'httparty'

Dir[File.dirname(__FILE__) + '/clashinator/*.rb'].each do |file|
  require file
end
