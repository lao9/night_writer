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

    def message_string_split_to_array
      @english_array = @file_input.split(//)
    end

    def character_orientation
      @english_array.each do |character|
        if letters_to_numbers.key(character)!= nil
          if @number_bool == false
            translation_builder(alphabet_hash["number"])
          end
          translation_builder(alphabet_hash[letters_to_numbers.key(character)])
          @number_bool = true
        elsif character == character.upcase
          translation_builder(alphabet_hash["capital"])
          translation_builder(alphabet_hash[character.downcase])
        elsif character == " "
            @number_bool = false
            translation_builder(alphabet_hash[character])
        else
            translation_builder(alphabet_hash[character])
        end
      end
    write_braille_to_file

    end

    def translation_builder(braille_array)
        @line_1 += braille_array[0]
        @line_2 += braille_array[1]
        @line_3 += braille_array[2]
        if @line_1.lenght >= 80
            write_braille_to_file
        end
    end


    def write_braille_to_file
      # puts braille_file(@Line_1)
      # puts braille_file(@line_2)
      # puts braille_file(@line_3)
      #





    #Once our each method is complete, we should add the final lines to our program using the “write braille to file” method since in the translation builder, they’re only added once the character limit reaches 80
    end




# binding.pry
end


@Hash = {crazy hash}
