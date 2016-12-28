module Clashinator
  # This class represents the location model
  class Location < Base
    def initialize(attrs)
      super(attrs)
    end

    def self.list_locations(http, options = {})
      new_options = prepare_options(options)
      response = http.get('/v1/locations', new_options)
      parsed = JSON.parse(response.body)

      if response.success?
        return Clashinator::ArrayResource.new(
          Clashinator::Location, parsed['items'], parsed['paging']
        )
      end
      raise parsed['message'] unless response.success?
    end

    def self.location_info(http, location_id)
      response = http.get("/v1/locations/#{location_id}")
      parsed = JSON.parse(response.body)

      return new(parsed) if response.success?
      raise parsed['message'] unless response.success?
    end

    def self.location_clan_rankings(http, location_id, options = {})
      new_options = prepare_options(options)
      response = http.get("/v1/locations/#{location_id}/rankings/clans", new_options)
      parsed = JSON.parse(response.body)

      if response.success?
        return Clashinator::ArrayResource.new(
          Clashinator::ClanRanking, parsed['items'], parsed['paging']
        )
      end
      raise parsed['reason'] unless response.success?
    end

    def self.location_player_rankings(http, location_id, options = {})
      response = http.get(
        "/v1/locations/#{location_id}/rankings/players",
        prepare_options(options)
      )
      parsed = JSON.parse(response.body)

      return Clashinator::ArrayResource.new(
        Clashinator::PlayerRanking, parsed['items'], parsed['paging']
      ) if response.success?
      raise parsed['reason'] unless response.success?
    end
  end
end
