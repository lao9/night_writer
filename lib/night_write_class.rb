require "../night_writer/lib/hash_library"
require 'pry'

class NightWrite
  attr_reader :file_input
  attr_accessor :number_bool, :line_1, :line_2, :line_3, :english_array
  def initialize(file_input)
    @number_bool = false
    @english_array = []
    @line_1 = ""
    @line_2 = ""
    @line_3 = ""
    @file_input = file_input
  end




end
