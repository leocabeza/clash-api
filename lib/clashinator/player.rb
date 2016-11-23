module Clashinator
  # This class represents the player model
  class Player < Base
    def initialize(attrs)
      super(attrs)
    end

    def self.player_info(player_tag)
      player_tag.gsub!('#', '%23')
      response = get("/v1/players/#{player_tag}", http_default_options)

      return new(response.parsed_response) if response.ok?
      raise response['reason'] unless response.ok?
    end
  end
end
