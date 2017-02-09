require '../night_writer/lib/night_write_class'
require 'pry'

#vv file I/O ARGV grabs from command line vv
input_string = File.open(ARGV[0], "r").read
output_file = File.open(ARGV[1], "w")

test_write = NightWrite.new(input_string, output_file)
test_write.message_string_split_to_array
test_write.write_final_lines

puts "Created ‘#{ARGV[1]}’ containing #{test_write.count} characters"
