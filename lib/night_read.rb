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

  #binding.pry
  # letters_to_numbers
  # alphabet_hash

  def file_prepper
    # input_string = File.open(ARGV[0], "r").read
    # output_file = File.open(ARGV[1], "w")
    # puts "Created ‘#{ARGV[1]}’ containing #{input_string.count} characters"
  end

end

# $ ruby ./lib/night_write.rb message.txt braille.txt
# Created 'braille.txt' containing 256 characters
#
# $ ruby ./lib/night_read.rb braille.txt original_message.txt
# Created 'original_message.txt' containing 256 characters.
#
# input_file = File.open(ARGV[0], "r")
# output_file = File.open(ARGV[1], "w")

# binding.pry
# ""
