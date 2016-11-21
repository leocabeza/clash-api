require_relative 'util/camelcase.rb'
require_relative 'util/underscore.rb'

module Clashinator
  # This is the base class for the other entities
  class Base
    include HTTParty
    include Underscorable
    extend Camelizable

    base_uri 'https://api.clashofclans.com'

    CONFIG = YAML.load_file('config/secrets.yml')
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
        val = verify_hash_that_are_objects(lower_camel_cased, val)
        val = verify_array_of_classes(lower_camel_cased, val)
        instance_variable_set "@#{lower_camel_cased}", val
      end
    end

    # TODO: implement paging for some models, may be with a Pageable module?

    def verify_hash_that_are_objects(lower_camel_cased, val)
      if OBJECT_MAP.key? lower_camel_cased.to_sym
        class_name = 'Clashinator::' \
          "#{OBJECT_MAP[lower_camel_cased.to_sym]}"
        val = Object
              .const_get(class_name)
              .new(val)
      end

      val
    end

    def verify_array_of_classes(lower_camel_cased, val)
      if CLASS_MAP.key?(lower_camel_cased.to_sym) && val.is_a?(Array)
        class_name = 'Clashinator::' \
          "#{CLASS_MAP[lower_camel_cased.to_sym]}"
        val = self.class.as_array_of(Object.const_get(class_name), val)
      end

      val
    end

    def self.http_default_options
      {
        headers: {
          'Authorization' => "Bearer #{CONFIG['token_test']}"
        }
      }
    end

    def self.prepare_query_options(options)
      # new hash to store camelcased attributes, to make it work
      # with the official API
      query_options = {}
      options.each do |name, val|
        name = to_camel_case(name.to_s)
        val.gsub!('#', '%23') if val.class == String
        query_options[name.to_sym] = val
      end

      # duplicate http_default_options to add query_options
      http_default_options.dup.merge(query: query_options)
    end

    def self.as_array_of(model, array)
      new_array = []

      array.each do |arr|
        new_array.push(
          model.new(arr)
        )
      end

      new_array
    end
  end
end
