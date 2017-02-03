
hash_test = {"a" => "0.....", "b" => "0.0..."}

# $ ruby ./lib/night_write.rb message.txt braille.txt
# Created 'braille.txt' containing 256 characters
#
# $ ruby ./lib/night_read.rb braille.txt original_message.txt
# Created 'original_message.txt' containing 256 characters.

input_file = File.open(ARGV[0], "r")
output_file = File.open(ARGV[1], "w")
