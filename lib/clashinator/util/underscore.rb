# module to convert camelcase to underscore
module Underscorable
  def to_underscore(name)
    modified_word = name.dup
    modified_word.gsub!(/::/, '/')
    modified_word.gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
    modified_word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
    modified_word.tr!('-', '_')
    modified_word.downcase!
    modified_word
  end
end
