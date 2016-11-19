# module to convert underscore to camel-case
module Camelizable
  def to_camel_case(name)
    name.split('_').inject([]) do |buffer, e|
      buffer.push(buffer.empty? ? e : e.capitalize)
    end.join
  end
end
