module Clashinator
  # This class represents the clan model
  class Clan < Base
    def initialize(attrs)
      super(attrs)
    end

    def self.clan_info(http, clan_tag)
      clan_tag.gsub!('#', '%23')
      response = http.get(
        "/v1/clans/#{clan_tag}"
      )
      parsed = JSON.parse(response.body)

      return new(parsed) if response.success?
      raise parsed['reason'] unless response.success?
    end

    def self.search_clans(http, options)
      new_options = prepare_options(options)
      response = http.get('/v1/clans', new_options)
      parsed = JSON.parse(response.body)

      if response.success?
        return Clashinator::ArrayResource.new(
          Clashinator::Clan, parsed['items'], parsed['paging']
        )
      end

      raise parsed['message'] unless response.success?
    end

    def self.list_clan_members(http, clan_tag, options = {})
      new_options = prepare_options(options)
      clan_tag.gsub!('#', '%23')
      response = http.get("/v1/clans/#{clan_tag}/members", new_options)
      parsed = JSON.parse(response.body)
      if response.success?
        return Clashinator::ArrayResource.new(
          Clashinator::Player, parsed['items'], parsed['paging']
        )
      end
      raise parsed['message'] unless response.success?
    end

    def self.clan_war_log(http, clan_tag, options = {})
      # response.code will be 403 if clan war log is set to private
      new_options = prepare_options(options)
      clan_tag.gsub!('#', '%23')
      response = http.get("/v1/clans/#{clan_tag}/warlog", new_options)
      parsed = JSON.parse(response.body)

      if response.success?
        return Clashinator::ArrayResource.new(
          Clashinator::Warlog, parsed['items'], parsed['paging']
        )
      end
      raise parsed['reason'] unless response.success?
    end
  end
end
