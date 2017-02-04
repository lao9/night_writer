require "../night_writer/lib/hash_library"
require "pry"

binding.pry

input_string = File.open(ARGV[0], "r").read
output_file = File.open(ARGV[1], "w")
puts "Created ‘#{ARGV[1]}’ containing #{input_string.length} characters"


class NightRead
  attr_accessor :capital_bool, :number_bool, :normal_line
  def initialize
    #@hash_library = hash_library
    @capital_bool = false
    @number_bool = false
    @normal_line = ""
  end

  def file_prepper
    puts "I'm here"
    # input_string = File.open(ARGV[0], "r").read
    # output_file = File.open(ARGV[1], "w")
    # puts "Created ‘#{ARGV[1]}’ containing #{input_string.count} characters"
  end

end


# binding.pry
#
# ""



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
