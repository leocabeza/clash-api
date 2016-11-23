module Clashinator
  # This class represents the array resource model
  # This is only for array-based responses
  # that contains an items attribute and
  # a paging attribute
  # TODO: when using array_resource,
  # if after or before attributes are wrong
  # an error will be thrown
  class ArrayResource
    attr_accessor :items, :paging, :model

    def initialize(model, items, paging = {})
      # if after and before are equal, it means it's end of pagination
      @model = model
      @items = as_array_of_model(items)
      @paging = Clashinator::ArrayResource::Cursor.new(
        paging['cursors']['after'],
        paging['cursors']['before']
      ) if paging.key?('cursors')
    end

    private def as_array_of_model(array)
      new_array = []

      array.each do |arr|
        new_array.push(@model.new(arr)) if @model.class == Class
      end

      new_array
    end

    # This class represent the cursor model
    # that contains an after & before attribute
    # for properly paging array resources
    class Cursor
      attr_accessor :after, :before

      def initialize(after, before)
        @after = after
        @before = before
      end
    end
  end
end
