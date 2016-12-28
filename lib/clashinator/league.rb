module Clashinator
  # This class represents the league model
  class League < Base
    def initialize(attrs)
      super(attrs)
    end

    def self.list_leagues(http, options = {})
      new_options = prepare_options(options)
      response = http.get('/v1/leagues', new_options)
      parsed = JSON.parse(response.body)

      if response.success?
        return Clashinator::ArrayResource.new(
          Clashinator::League, parsed['items'], parsed['paging']
        )
      end
      raise parsed['message'] unless response.success?
    end

    def self.league_info(http, league_id)
      response = http.get("/v1/leagues/#{league_id}")
      parsed = JSON.parse(response.body)

      return new(parsed) if response.success?
      raise parsed['message'] unless response.success?
    end

    def self.league_seasons(http, league_id, options = {})
      new_options = prepare_options(options)
      response = http.get("/v1/leagues/#{league_id}/seasons", new_options)
      parsed = JSON.parse(response.body)

      if response.success?
        return Clashinator::ArrayResource.new(
          Clashinator::Season, parsed['items'], parsed['paging']
        )
      end
      raise parsed['reason'] unless response.success?
    end

    def self.league_season_rankings(http, league_id, season_id, options = {})
      # only available for legend_league
      response = prepare_response_season_rankings(
        league_id, season_id, http, options
      )
      parsed = JSON.parse(response.body)

      if response.success?
        return Clashinator::ArrayResource.new(
          Clashinator::PlayerRanking, parsed['items'], parsed['paging']
        )
      end
      raise parsed['reason'] unless response.success?
    end

    def self.prepare_response_season_rankings(league_id, season_id, http, options)
      http.get(
        "/v1/leagues/#{league_id}/seasons/#{season_id}",
        prepare_options(options)
      )
    end

    private_class_method :prepare_response_season_rankings
  end
end
