require "../night_writer/lib/hash_library"
require 'pry'

class NightWrite
  attr_reader :number_bool, :file_input, :line_1, :line_2, :line_3, :english_array, :braille_file, :test_output
  def initialize(file_input, braille_file)
    @number_bool = false
    @english_array = []
    @line_1 = ""
    @line_2 = ""
    @line_3 = ""
    @file_input = file_input.chomp
    @braille_file = braille_file
    @test_output = ""
  end

    def message_string_split_to_array
      @english_array = @file_input.split(//)
      @english_array.each do |character|
        character_orientation(character)
      end
    end

    def character_orientation(character)
      if letters_to_numbers.key(character)!= nil
        if @number_bool == false
          @number_bool = true
          translation_builder(alphabet_hash["number"])
          translation_builder(alphabet_hash[letters_to_numbers.key(character)])
          return alphabet_hash["number"], alphabet_hash[letters_to_numbers.key(character)]
        else
          @number_bool = true
          translation_builder(alphabet_hash[letters_to_numbers.key(character)])
          return alphabet_hash[letters_to_numbers.key(character)]
        end
      elsif character == " "
          @number_bool = false
          translation_builder(alphabet_hash[character])
          return alphabet_hash[character]
      elsif character == character.upcase && symbols[character] == nil
        translation_builder(alphabet_hash["capital"])
        translation_builder(alphabet_hash[character.downcase])
        return alphabet_hash["capital"], alphabet_hash[character.downcase]
      else
          translation_builder(alphabet_hash[character])
          return alphabet_hash[character]
      end
    end

    def translation_builder(braille_array)
        @line_1 += braille_array[0]
        @line_2 += braille_array[1]
        @line_3 += braille_array[2]
        if @line_1.length >= 80
            write_braille_to_file
        end
    end

    def write_braille_to_file
      braille_file.puts(@line_1)
      braille_file.puts(@line_2)
      braille_file.puts(@line_3)
      @test_output += @line_1
      @test_output += @line_2
      @test_output += @line_3
      @line_1 = ""
      @line_2 = ""
      @line_3 = ""
    end

    def write_final_lines
      write_braille_to_file
    end
end
