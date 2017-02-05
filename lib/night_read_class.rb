require "../night_writer/lib/hash_library"
require "pry"

class NightRead
  attr_reader :file_input
  attr_accessor :capital_bool, :number_bool, :normal_line, :line_array, :line1, :line2, :line3

  def initialize(file_input)
    @capital_bool = false
    @number_bool = false
    @normal_line = ""
    @file_input = file_input
    @line_array = []
    @line1 = ""
    @line2 = ""
    @line3 = ""
  end

  def loop_through_braille_lines(braille_string)

    @line_array = braille_string.split("\n") #remove line breaks

    until line_array.empty?
      @line1 = line_array.shift
      @line2 = line_array.shift
      @line3 = line_array.shift
      character_builder(@line1, @line2, @line3)
    end

    write_message_to_file

  end

  def character_builder(line1, line2, line3)
    until line3 == ""
      braille_char = [line1[0,2] , line2[0,2] , line3[0,2] ]
      line1 = line1[2..-1]
      line2 = line2[2..-1]
      line3 = line3[2..-1]
      capital_number_checker(braille_char)
    end
  end

  def capital_number_checker(character)

    if alphabet_hash.key(character) == "numbers"
      @number_bool = true
    elsif alphabet_hash.key(character) == "capitals"
      @capital_bool = true
    elsif alphabet_hash.key(character) == " "
      @number_bool = false
    else

    end

    if @number_bool
      translation_builder(letters_to_numbers[alphabet_hash.key(character)])
    elsif @capital_bool
      translation_builder(alphabet_hash.key(character).upcase)
      @capital_bool = false
    else
      translation_builder(alphabet_hash.key(character))
    end

  end

  def translation_builder(letter)
  end

  def write_message_to_file
  end

end
