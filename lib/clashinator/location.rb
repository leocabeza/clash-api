module Clashinator
  # This class represents the location model
  class Location < Base
    def initialize(attrs)
      super(attrs)
    end

    def self.list_locations(options = {})
      new_options = prepare_query_options(options)
      response = get('/v1/locations', new_options)

      return as_locations(response.parsed_response['items']) if response.ok?
      raise response['message'] unless response.ok?
    end

    def self.location_info(location_id)
      response = get("/v1/locations/#{location_id}", http_default_options)

      return new(response.parsed_response) if response.ok?
      raise response['message'] unless response.ok?
    end

    def self.location_clan_rankings(location_id, options = {})
      new_options = prepare_query_options(options)
      response = get("/v1/locations/#{location_id}/rankings/clans", new_options)

      return as_clan_rankings(response.parsed_response['items']) if response.ok?
      raise response['reason'] unless response.ok?
    end

    def self.location_player_rankings(location_id, options = {})
      new_options = prepare_query_options(options)
      response = get(
        "/v1/locations/#{location_id}/rankings/players",
        new_options
      )

      if response.ok?
        return as_player_rankings(response.parsed_response['items'])
      end
      raise response['reason'] unless response.ok?
    end
  end
end
