module Clashinator
  # This class represents the player model
  class Player < Base
    def initialize(attrs)
      super(attrs)
    end

    def self.player_info(http, player_tag)
      player_tag.gsub!('#', '%23')
      response = http.get("/v1/players/#{player_tag}")
      parsed = JSON.parse(response.body)

      return new(parsed) if response.success?
      raise parsed['reason'] unless response.success?
    end
  end
end
