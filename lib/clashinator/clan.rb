module Clashinator
  # This class represents the clan model
  class Clan

    attr_accessor :tag

    include HTTParty

    base_uri 'https://api.clashofclans.com'

    def initialize(tag)
      self.tag = '%23' + tag
    end

    def location
      self.class.get "/v1/clans/#{tag}"
    end
  end
end
