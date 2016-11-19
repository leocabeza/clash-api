module Clashinator
  # This class represents the clan model
  class Clan < Base
    def initialize(attrs)
      attrs.each do |name, val|
        # convert camelCase to underscore
        lower_camel_cased = to_underscore(name)
        # dinamically set attr reader
        (class << self; self; end).send(:attr_reader, lower_camel_cased.to_sym)
        val = Clashinator::Location.new(val) if lower_camel_cased == 'location'
        if lower_camel_cased == 'badge_urls'
          val = Clashinator::BadgeUrl.new(val)
        end
        if lower_camel_cased == 'member_list' && val.is_a?(Array)
          val = self.class.as_players(val)
        end
        # set instance variables dinamically
        instance_variable_set "@#{lower_camel_cased}", val
      end
    end

    def self.clan_info(clan_tag)
      clan_tag = CGI.escape(clan_tag)
      response = get("/v1/clans/#{clan_tag}", http_default_options)

      return new(response.parsed_response) if response.ok?
      raise response['reason'] unless response.ok?
    end

    def self.search_clans(options)
      new_options = prepare_query_options(options)
      response = get('/v1/clans', new_options)

      return as_clans(response.parsed_response['items']) if response.ok?
      raise response['message'] unless response.ok?
    end

    def self.list_clan_members(clan_tag, options)
      new_options = prepare_query_options(options)
      clan_tag = CGI.escape(clan_tag)
      response = get("/v1/clans/#{clan_tag}/members", new_options)

      return as_players(response.parsed_response['items']) if response.ok?
      raise response['message'] unless response.ok?
    end

    def self.clan_war_log(clan_tag, options)
      # response.code will be 403 if clan war log is set to private
      new_options = prepare_query_options(options)
      clan_tag = CGI.escape(clan_tag)
      response = get("/v1/clans/#{clan_tag}/warlog", new_options)

      if response.ok?
        return as_warlogs(
          response.parsed_response['items']
        )
      end
      raise response['reason'] unless response.ok?
    end
  end
end
