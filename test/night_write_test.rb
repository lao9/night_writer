require "minitest"
require "minitest/pride"
require "minitest/autorun"
require "../night_writer/lib/night_write_class"

class NightWriteTest < Minitest::Test
  attr_reader :braille_write

  def setup
    @braille_write = NightWrite.new(load_english_a , sample_braille_output_file(1))
  end

  def test_that_hashes_load
    refute_nil alphabet_hash
    refute_nil letters_to_numbers
    assert_equal 35, alphabet_hash.count
    assert_equal 10, letters_to_numbers.count
  end

  def test_expected_hash_keys_and_values
    assert_equal [".0","00",".0"], alphabet_hash["w"]
    assert_equal ["..","0.","00"], alphabet_hash["?"]
    assert_equal "7", letters_to_numbers["g"]
    assert_equal "t", alphabet_hash.key([".0","00","0."])
    assert_equal "f", alphabet_hash.key(["00","0.",".."])
    assert_equal "j", letters_to_numbers.key("0")
  end

  def test_starting_values
    refute braille_write.number_bool
    assert_equal "", braille_write.line_1
    assert_equal "", braille_write.line_2
    assert_equal "", braille_write.line_3

  end

  def test_input_file
    assert_equal String, braille_write.file_input.class
    refute braille_write.file_input.empty?
  end

  def test_message_string_is_array
    assert_equal Array, braille_write.english_array.class
  end

  def test_message_string_splits
    a = "hello"
    braille_write_test = NightWrite.new(a , sample_braille_output_file(2))

    assert_equal a.length , braille_write_test.message_string_split_to_array.count
    #could have hardcoded
    # test message_string_split_to_array
  end

  def test_character_orientation_letters_caps
    assert_equal ["0.","..",".."] ,@braille_write.character_orientation("a")
    var = @braille_write.character_orientation("A")
    assert_equal [["..", "..", ".0"], ["0.", "..", ".."]], var
    assert_equal [["..", "..", ".0"],["00","0.",".."]] , @braille_write.character_orientation("F")
  end

  def test_character_orientation_numbers
    assert_equal [[".0", ".0", "00"],["0.","..",".."]], @braille_write.character_orientation("1")
    assert @braille_write.number_bool

    assert_equal ["0.","0.",".."] ,  @braille_write.character_orientation("2")

    assert_equal ["..","..",".."] , @braille_write.character_orientation(" ")

    refute @braille_write.number_bool
  end

  def test_translation_builder_lays_bricks
    @braille_write.translation_builder(["0.","..",".."])
    assert_equal "0." , @braille_write.line_1
    assert_equal ".." , @braille_write.line_2
    assert_equal ".." , @braille_write.line_3
    @braille_write.translation_builder(["0.","0.",".."])
    assert_equal "0.0." , @braille_write.line_1
    assert_equal "..0." , @braille_write.line_2
    assert_equal "...." , @braille_write.line_3
  end

  def test_a_integration
    a_test = NightWrite.new(load_english_a , sample_braille_output_file(4))
    a_test.message_string_split_to_array
    a_test.write_final_lines
    assert_equal "0.....", a_test.test_output
  end

  def test_hello
    a_test = NightWrite.new(load_english_hello , sample_braille_output_file(5))
    a_test.message_string_split_to_array
    a_test.write_final_lines
    assert_equal "0.0.0.0.0.00.00.0..0....0.0.0.", a_test.test_output
  end

  def test_hello_world
    a_test = NightWrite.new("!", sample_braille_output_file(6))
    a_test.message_string_split_to_array
    a_test.write_final_lines
    assert_equal "..000.", a_test.test_output
  end

  def test_write_braille_to_file_caps_characters
    write = NightWrite.new(load_english_symbols_letters , sample_braille_output_file(3))

    write.message_string_split_to_array
    write.write_final_lines

  end




# further tests for this feel like just running the night write class itself
  # def test_character_orientation_number
  #       load_english_a
  #       refute @number_bool == true
  # end

  # def test_translation_builder
  #     assert_equal ["0.0.00000.00....0.0.0.0.0....00.0.0.00.."], translation_builder( load_english_hello_world_numbers)
  #
  #
  #
  # end




  # vv test text files for loading vv

  def load_english_a
    File.open("test/test_files/english_a.txt", "r").read
  end

  def load_english_hello
    File.open("test/test_files/english_hello.txt", "r").read
  end

  def load_english_hello_world
    File.open("test/test_files/english_hello_world.txt", "r").read
  end

  def load_english_hello_world_caps
    File.open("test/test_files/english_hello_world_caps.txt", "r").read
  end

  def load_english_hello_world_numbers
      File.open("test/test_files/english_hello_world_numbers.txt", "r").read
  end

  def load_english_symbols_letters
    File.open("test/test_files/english_symbols_letters.txt", "r").read
  end

  def sample_braille_output_file(file_num)
    File.open("test/output_files/braille_translation#{file_num}.txt","w")
  end

end
