module Clashinator
  # This class represents the league model
  class League < Base
    def initialize(attrs)
      super(attrs)
    end

    def self.list_leagues(token, options = {})
      new_options = prepare_options(token, options)
      response = get('/v1/leagues', new_options)

      if response.ok?
        return Clashinator::ArrayResource.new(
          Clashinator::League, response.parsed_response['items'],
          response.parsed_response['paging']
        )
      end
      raise response['message'] unless response.ok?
    end

    def self.league_info(token, league_id)
      new_options = prepare_options(token)
      response = get("/v1/leagues/#{league_id}", new_options)

      return new(response.parsed_response) if response.ok?
      raise response['message'] unless response.ok?
    end

    def self.league_seasons(token, league_id, options = {})
      new_options = prepare_options(token, options)
      response = get("/v1/leagues/#{league_id}/seasons", new_options)

      if response.ok?
        return Clashinator::ArrayResource.new(
          Clashinator::Season, response.parsed_response['items'],
          response.parsed_response['paging']
        )
      end
      raise response['reason'] unless response.ok?
    end

    def self.league_season_rankings(token, league_id, season_id, options = {})
      # only available for legend_league
      response = prepare_response_season_rankings(
        league_id, season_id, token, options
      )
      if response.ok?
        return Clashinator::ArrayResource.new(
          Clashinator::PlayerRanking, response.parsed_response['items'],
          response.parsed_response['paging']
        )
      end
      raise response['reason'] unless response.ok?
    end

    def self.prepare_response_season_rankings(league_id, season_id, token, options)
      get(
        "/v1/leagues/#{league_id}/seasons/#{season_id}",
        prepare_options(token, options)
      )
    end

    private_class_method :prepare_response_season_rankings
  end
end
