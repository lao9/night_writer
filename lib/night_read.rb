require "../night_writer/lib/night_read_class"
require "pry"

input_string = File.open(ARGV[0], "r").read
output_file = File.open(ARGV[1], "w")
puts "Created ‘#{ARGV[1]}’ containing #{input_string.length} characters"

instance = NightRead.new(input_string, output_file)
instance.create_lines_of_braille(instance.file_input)
