require "minitest"
require "minitest/pride"
require "minitest/autorun"
require "../night_writer/lib/night_read_class"
require "pry"

class NightReadTest < Minitest::Test
  attr_reader :btext
  def setup
    @btext = NightRead.new(load_braille_a, create_sample_txt_output_file)
  end

  def test_default_variables
    refute btext.capital_bool
    refute btext.number_bool
    assert_equal "", btext.normal_line
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

  def test_file_input
    assert_equal String, btext.file_input.class
    refute btext.file_input.empty?
  end

  def test_one_character_builder
    @btext.loop_through_braille_lines(@btext.file_input)
    assert_equal "a", @btext.test_output.chomp
  end

  def test_capital_character_builder
    skip
  end

  def test_extra_line_creation
    skip
    sym_test = NightRead.new(load_braille_symbols_letters, create_sample_txt_output_file)
    sym_test.loop_through_braille_lines(sym_test.file_input)
    assert sym_test.line_array.empty?, "Looks like we still have some things in our line array."
    assert_equal "00..00..0.", sym_test.line1
    assert_equal ".....0...0", sym_test.line2
    assert_equal "00.000.000", sym_test.line3
    binding.pry
  end

  def test_number_character_builder
    skip
  end

  def load_braille_a
    File.open("test/test_files/braille_a.txt").read
  end

  def load_braille_hello
    File.open("test/test_files/braille_hello.txt", "r").read
  end

  def load_braille_hello_word
    File.open("test/test_files/braille_hello_world.txt", "r").read
  end

  def load_braille_hello_word_caps
    File.open("test/test_files/braille_hello_world_caps.txt", "r").read
  end

  def load_braille_symbols_letters
    File.open("test/test_files/braille_symbols_letters.txt", "r").read
  end

  def load_braille_numbers
    File.open("test/test_files/braille_numbers.txt", "r").read
  end

  def load_braille_hello_word_numbers
    File.open("test/test_files/braille_hello_world_numbers.txt", "r").read
  end

  def create_sample_txt_output_file
    File.open("test/output_files/english_translation_test.txt", "w")
  end

  def read_sample_txt_output_file
    File.open("test/output_files/english_translation_test.txt", "r").read
  end

end
