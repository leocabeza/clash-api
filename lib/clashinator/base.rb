require_relative 'util/camelcase.rb'
require_relative 'util/underscore.rb'

module Clashinator
  # This is the base class for the other entities
  class Base
    include HTTParty
    include Underscorable
    extend Camelizable

    base_uri 'https://api.clashofclans.com'

    CLASS_MAP = {
      member_list: 'Player', achievements: 'Achievement',
      troops: 'Troop', heroes: 'Hero', spells: 'Spell'
    }.freeze
    OBJECT_MAP = {
      opponent: 'Clan', league: 'League',
      location: 'Location', badge_urls: 'BadgeUrl',
      icon_urls: 'BadgeUrl', clan: 'Clan'
    }.freeze

    def initialize(attrs)
      attrs.each do |name, val|
        lower_camel_cased = to_underscore(name)
        (class << self; self; end).send(:attr_reader, lower_camel_cased.to_sym)
        val = verify_hash_that_are_objects(lower_camel_cased.to_sym, val)
        val = verify_array_of_classes(lower_camel_cased.to_sym, val)
        instance_variable_set "@#{lower_camel_cased}", val
      end
    end

    def verify_hash_that_are_objects(lower_camel_cased, val)
      if OBJECT_MAP.key? lower_camel_cased
        class_name = 'Clashinator::' \
          "#{OBJECT_MAP[lower_camel_cased]}"
        val = Object
              .const_get(class_name)
              .new(val)
      end

      val
    end

    def verify_array_of_classes(lower_camel_cased, val)
      key_found = CLASS_MAP.key?(lower_camel_cased)
      val = get_array_resource(lower_camel_cased, val) if key_found

      val
    end

    private def get_array_resource(lower_camel_cased, val)
      class_name = "Clashinator::#{CLASS_MAP[lower_camel_cased]}"
      model = Object.const_get(class_name)
      # this condition is for paging structures
      # for instance Clan.search_clans
      if val.is_a? Array
        val = Clashinator::ArrayResource.new(model, val)
      # this other condition is for array based structures with no paging
      # for instance member_list of Clan.clan_info 'member_list' attribute
      elsif val.is_a?(Hash) && val.key?(:items) && val.key?(:paging)
        val = Clashinator::ArrayResource.new(
          model, val['items'], val['paging']
        )
      end

      val
    end

    def self.http_default_options(token)
      {
        headers: {
          'Authorization' => "Bearer #{token}"
        }
      }
    end

    def self.prepare_options(token, query_options = {})
      # new hash to store camelcased attributes, to make it work
      # with the official API
      new_query_options = {}
      query_options.each do |name, val|
        name = to_camel_case(name.to_s)
        val.gsub!('#', '%23') if val.class == String
        new_query_options[name.to_sym] = val
      end

      # duplicate http_default_options to add new_query_options
      http_default_options(token).dup.merge(query: new_query_options)
    end

    private_class_method :http_default_options
  end
end
