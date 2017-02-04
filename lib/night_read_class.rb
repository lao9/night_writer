require "../night_writer/lib/hash_library"
require "pry"

class NightRead
  attr_accessor :capital_bool, :number_bool, :normal_line
  def initialize
    #@hash_library = hash_library
    @capital_bool = false
    @number_bool = false
    @normal_line = ""
  end

end
