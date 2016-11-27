module Clashinator
  # This class represents the player model
  class Player < Base
    def initialize(attrs)
      super(attrs)
    end

    def self.player_info(token, player_tag)
      player_tag.gsub!('#', '%23')
      new_options = prepare_options(token)
      response = get("/v1/players/#{player_tag}", new_options)

      return new(response.parsed_response) if response.ok?
      raise response['reason'] unless response.ok?
    end
  end
end
