module Clashinator
  # Client class that acts as
  # interface of http methods
  # available for the client itself
  class Client
    attr_reader :token, :uri, :headers

    def initialize(token)
      @token = token
      @uri = YAML.load_file('config/config.yml')['url']
      @headers = { 'Authorization' => "Bearer #{@token}" }
      @conn = Faraday.new(
        url: @uri,
        headers: @headers
      )
    end

    # client class methods

    def search_clans(options)
      Clashinator::Clan.search_clans(@conn, @token, options)
    end

    def clan_info(tag)
      Clashinator::Clan.clan_info(@conn, @token, tag)
    end

    def list_clan_members(tag, options = {})
      Clashinator::Clan.list_clan_members(@conn, @token, tag, options)
    end

    def clan_war_log(tag, options = {})
      Clashinator::Clan.clan_war_log(@conn, @token, tag, options)
    end

    # location class methods

    def list_locations(options = {})
      Clashinator::Location.list_locations(@conn, @token, options)
    end

    def location_info(location_id)
      Clashinator::Location.location_info(@conn, @token, location_id)
    end

    def location_clan_rankings(location_id, options = {})
      Clashinator::Locaton.location_clan_rankings(
        @conn, @token, location_id, options
      )
    end

    def location_player_rankings(player_tag, options = {})
      Clashinator::Location.location_player_rankings(
        @conn, @token, player_tag, options
      )
    end

    # league class methods

    def list_leagues(options = {})
      Clashinator::League.list_leagues(@conn, @token, options)
    end

    def league_info(league_id)
      Clashinator::League.league_info(@conn, @token, league_id)
    end

    def league_seasons(league_id, options = {})
      Clashinator::League.league_seasons(@conn, @token, league_id, options)
    end

    def league_season_rankings(league_id, season_id, options = {})
      Clashinator::League.league_season_rankings(
        @conn, @token, league_id, season_id, options
      )
    end

    # player class methods

    def player_info(tag)
      Clashinator::Player.player_info(@conn, @token, tag)
    end
  end
end
