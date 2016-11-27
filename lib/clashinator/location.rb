module Clashinator
  # This class represents the location model
  class Location < Base
    def initialize(attrs)
      super(attrs)
    end

    def self.list_locations(token, options = {})
      new_options = prepare_options(token, options)
      response = get('/v1/locations', new_options)

      if response.ok?
        return Clashinator::ArrayResource.new(
          Clashinator::Location, response.parsed_response['items'],
          response.parsed_response['paging']
        )
      end
      raise response['message'] unless response.ok?
    end

    def self.location_info(token, location_id)
      new_options = prepare_options(token)
      response = get("/v1/locations/#{location_id}", new_options)

      return new(response.parsed_response) if response.ok?
      raise response['message'] unless response.ok?
    end

    def self.location_clan_rankings(token, location_id, options = {})
      new_options = prepare_options(token, options)
      response = get("/v1/locations/#{location_id}/rankings/clans", new_options)

      if response.ok?
        return Clashinator::ArrayResource.new(
          Clashinator::ClanRanking, response.parsed_response['items'],
          response.parsed_response['paging']
        )
      end
      raise response['reason'] unless response.ok?
    end

    def self.location_player_rankings(token, location_id, options = {})
      response = get(
        "/v1/locations/#{location_id}/rankings/players",
        prepare_options(token, options)
      )

      return Clashinator::ArrayResource.new(
        Clashinator::PlayerRanking, response.parsed_response['items'],
        response.parsed_response['paging']
      ) if response.ok?
      raise response['reason'] unless response.ok?
    end
  end
end
