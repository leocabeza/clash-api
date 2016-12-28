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
      Clashinator::Clan.search_clans(@conn, options)
    end

    def clan_info(tag)
      Clashinator::Clan.clan_info(@conn, tag)
    end

    def list_clan_members(tag, options = {})
      Clashinator::Clan.list_clan_members(@conn, tag, options)
    end

    def clan_war_log(tag, options = {})
      Clashinator::Clan.clan_war_log(@conn, tag, options)
    end

    # location class methods

    def list_locations(options = {})
      Clashinator::Location.list_locations(@conn, options)
    end

    def location_info(location_id)
      Clashinator::Location.location_info(@conn, location_id)
    end

    def location_clan_rankings(location_id, options = {})
      Clashinator::Locaton.location_clan_rankings(
        @conn, location_id, options
      )
    end

    def location_player_rankings(player_tag, options = {})
      Clashinator::Location.location_player_rankings(
        @conn, player_tag, options
      )
    end

    # league class methods

    def list_leagues(options = {})
      Clashinator::League.list_leagues(@conn, options)
    end

    def league_info(league_id)
      Clashinator::League.league_info(@conn, league_id)
    end

    def league_seasons(league_id, options = {})
      Clashinator::League.league_seasons(@conn, league_id, options)
    end

    def league_season_rankings(league_id, season_id, options = {})
      Clashinator::League.league_season_rankings(
        @conn, league_id, season_id, options
      )
    end

    # player class methods

    def player_info(tag)
      Clashinator::Player.player_info(@conn, tag)
    end
  end
end
