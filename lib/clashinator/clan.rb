module Clashinator
  # This class represents the clan model
  class Clan < Base
    def initialize(attrs)
      super(attrs)
    end

    def self.clan_info(token, clan_tag)
      clan_tag.gsub!('#', '%23')
      new_options = prepare_options(token)
      response = get(
        "/v1/clans/#{clan_tag}",
        new_options
      )

      return new(response.parsed_response) if response.ok?
      raise response['reason'] unless response.ok?
    end

    def self.search_clans(token, options)
      new_options = prepare_options(token, options)
      # TODO: options[:name] should be at least 3 chars long
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

    def self.list_clan_members(token, clan_tag, options = {})
      new_options = prepare_options(token, options)
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

    def self.clan_war_log(token, clan_tag, options = {})
      # response.code will be 403 if clan war log is set to private
      new_options = prepare_options(token, options)
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
