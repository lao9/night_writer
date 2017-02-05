require '../night_writer/lib/night_write_class'
require 'pry'


input_string = File.open(ARGV[0], "r").read
output_file = File.open(ARGV[1], "w")
puts "Created ‘#{ARGV[1]}’ containing #{input_string.length} characters"


  def message_string_split_to_array
    english_array = NightWrite(file_input).split(//)
  end

  def character_orientation
    english_array.each do |character|
      if letters_to_numbers.key(character)!= nil
        if @number_bool == false
          translation_builder(alphabet_hash["number"])
        end
        translation_builder(alphabet_hash[letters_to_numbers.key(character)])
      elsif character == character.upcase
        translation_builder(alphabet_hash["capital"])
        translation_builder(alphabet_hash[character.downcase])
      end
    end
  end

  def translation_builder(braille_array)
  end





  end

# binding.pry
# ""
end
