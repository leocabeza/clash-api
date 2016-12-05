module Clashinator
  # This class represents the array resource model
  # This is only for array-based responses
  # that contains an items attribute and
  # a paging attribute
  class ArrayResource
    attr_accessor :items, :paging, :model

    def initialize(model, items, paging = { 'cursors' => {} })
      @model = model
      @items = as_array_of_model(items)
      @paging = Clashinator::ArrayResource::Cursor.new(
        paging['cursors']
      )
    end

    private def as_array_of_model(array)
      new_array = []

      array.each do |arr|
        new_array.push(@model.new(arr)) if @model.class == Class
      end

      new_array
    end

    # This class represent the cursor model
    # that contains an after attribute, a before attribute
    # or neither, for properly paging array resources
    class Cursor
      attr_accessor :after, :before

      def initialize(cursor_hash)
        @after = cursor_hash['after'] if cursor_hash.key?('after')
        @before = cursor_hash['before'] if cursor_hash.key?('before')
      end
    end
  end
end
