require "minitest"
require "minitest/pride"
require "minitest/autorun"
require "../night_writer/lib/night_read_class"
require "pry"

class NightReadTest < Minitest::Test
  attr_reader :btext
  def setup
    @btext = NightRead.new(load_braille_file_1)
  end

  def test_default_variables
    refute btext.capital_bool
    refute btext.number_bool
    assert_equal "", btext.normal_line
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

  def test_file_input
    assert_equal String, btext.file_input.class
    refute btext.file_input.empty?
  end

  def test_line_creation
    btext.loop_through_braille_lines(btext.file_input)
    assert btext.line_array.empty?, "Looks like we still have some things in our line array."
    assert_equal "00..00..0.", btext.line1
    assert_equal ".....0...0", btext.line2
    assert_equal "00.000.000", btext.line3
  end

  def test_one_character_builder
    btext1 = NightRead.new(load_small_braille_file)
    btext1.loop_through_braille_lines(btext1.file_input)
  end

  def test_capital_character_builder
    skip
  end

  def test_number_character_builder
    skip
  end

  def load_braille_file_1
    File.open("test/braille.txt", "r").read
  end

  def load_small_braille_file
    File.open("test/braille_small_input_test1.txt").read
  end

end
