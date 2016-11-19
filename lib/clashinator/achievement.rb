module Clashinator
  # This class represents the achievement model
  # through the player model
  class Achievement
    attr_accessor :name, :stars, :value, :target, :info, :completion_info

    def initialize(attributes)
      @name = attributes['name']
      @stars = attributes['stars']
      @value = attributes['value']
      @target = attributes['target']
      @info = attributes['info']
      @completion_info = attributes['completion_info']
    end
  end
end
