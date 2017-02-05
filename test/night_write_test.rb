require "minitest"
require "minitest/pride"
require "minitest/autorun"
require "../night_writer/lib/night_write_class"

class NightWriteTest < Minitest::Test
  attr_reader :braille_write

  def setup
    @braille_write = NightWrite.new(load_english_file_1)
  end


  def test_starting_values
    refute braille_write.number_bool
    assert_equal "", braille_write.line_1
    assert_equal "", braille_write.line_2
    assert_equal "", braille_write.line_3

  end

  def test_that_hashes_load
    refute_nil alphabet_hash
    refute_nil letters_to_numbers
    assert_equal 34, alphabet_hash.count
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

  def load_english_file_1
    File.open("test/english.txt", "r").read
  end

  def test_input_file
    assert_equal String, braille_write.file_input.class
    refute braille_write.file_input.empty?
  end

  def test_message_string_split_to_array
      assert_equal String, braille_write.file_input.class
      assert_equal Array, braille_write.english_array.class

  end

  def test_character_orientation
    

  end

#For *each* character:
# Is the character capitalized?
# If yes: Insert capital symbol into our “translation builder” method



end
