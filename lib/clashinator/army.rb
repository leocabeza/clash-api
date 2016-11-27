module Clashinator
  # This class represents the army model
  # through the player model
  class Army
    attr_accessor :name, :level, :max_level

    def initialize(attributes)
      @name = attributes['name']
      @level = attributes['level']
      @max_level = attributes['maxLevel']
    end
  end
end
