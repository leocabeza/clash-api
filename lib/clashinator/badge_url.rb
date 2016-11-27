module Clashinator
  # This class represents the BadgeUrl model
  class BadgeUrl
    attr_accessor :tiny, :small, :medium, :large

    def initialize(attributes)
      @tiny = attributes['tiny']
      @small = attributes['small']
      @medium = attributes['medium']
      @large = attributes['large']
    end
  end
end
