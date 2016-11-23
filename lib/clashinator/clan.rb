module Clashinator
  # This class represents the clan model
  class Clan < Base
    def initialize(attrs)
      super(attrs)
    end

    def self.clan_info(clan_tag)
      clan_tag.gsub!('#', '%23')
      response = get("/v1/clans/#{clan_tag}", http_default_options)

      return new(response.parsed_response) if response.ok?
      raise response['reason'] unless response.ok?
    end

    def self.search_clans(options)
      new_options = prepare_query_options(options)
      response = get('/v1/clans', new_options)

      if response.ok?
        return Clashinator::ArrayResource.new(
          Clashinator::Clan,
          response.parsed_response['items'],
          response.parsed_response['paging']
        )
      end
      raise response['message'] unless response.ok?
    end

    def self.list_clan_members(clan_tag, options)
      new_options = prepare_query_options(options)
      clan_tag.gsub!('#', '%23')
      response = get("/v1/clans/#{clan_tag}/members", new_options)

      if response.ok?
        return Clashinator::ArrayResource.new(
          Clashinator::Player, response.parsed_response['items'],
          response.parsed_response['paging']
        )
      end
      raise response['message'] unless response.ok?
    end

    def self.clan_war_log(clan_tag, options)
      # response.code will be 403 if clan war log is set to private
      new_options = prepare_query_options(options)
      clan_tag.gsub!('#', '%23')
      response = get("/v1/clans/#{clan_tag}/warlog", new_options)

      if response.ok?
        return Clashinator::ArrayResource.new(
          Clashinator::Warlog, response.parsed_response['items'],
          response.parsed_response['paging']
        )
      end
      raise response['reason'] unless response.ok?
    end
  end
end
