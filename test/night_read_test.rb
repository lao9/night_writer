require "minitest"
require "minitest/pride"
require "minitest/autorun"
require "../night_writer/lib/night_read_class"
require "pry"

class NightReadTest < Minitest::Test
  attr_reader :btext
  def setup
    @btext = NightRead.new(load_braille_a, create_sample_txt_output_file("english_translation_test"))
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
    @btext.create_lines_of_braille(@btext.file_input)
    assert_equal "a", @btext.test_output.chomp
  end

  def test_create_lines_of_braille
    sym_test = NightRead.new(load_braille_symbols_letters, create_sample_txt_output_file("english_translation_test4"))
    line_array, line1, line2, line3 = sym_test.create_lines_of_braille(sym_test.file_input)
    assert line_array.empty?, "Looks like we still have some things in our line array."
  end

  def test_number_character_builder
    braille_char, line1, line2, line3 = @btext.character_builder("0.0.00", "00...0", "0...00")
    assert_equal ["00",".0","00"], braille_char
    braille_char, line1, line2, line3 = @btext.character_builder("0.0.", "00..", "0...")
    assert_equal ["0.","..",".."], braille_char
    braille_char, line1, line2, line3 = @btext.character_builder("0.", "00", "0.")
    assert_equal ["0.","00","0."], braille_char
  end

  def test_number_detector
    @btext.capital_number_checker([".0", ".0", "00"])
    assert @btext.number_bool
  end

  def test_capital_detector
    @btext.capital_number_checker(["..", "..", ".0"])
    assert @btext.capital_bool
  end

  def test_space_detector
    @btext.capital_number_checker([".0", ".0", "00"])
    assert @btext.number_bool
    @btext.capital_number_checker(["..","..",".."])
    refute @btext.number_bool
  end

  def test_insert_into_translation_builder
    @btext.capital_number_checker([".0", ".0", "00"])
    assert @btext.number_bool
    assert_equal "1", @btext.insert_into_translation_builder(["0.","..",".."])
    @btext.capital_number_checker(["..","..",".."])
    refute @btext.number_bool
    assert_equal "a", @btext.insert_into_translation_builder(["0.","..",".."])
    @btext.capital_number_checker(["..", "..", ".0"])
    assert @btext.capital_bool
    assert_equal "A", @btext.insert_into_translation_builder(["0.","..",".."])
    assert_equal "v", @btext.insert_into_translation_builder(["0.","0.","00"])
    assert_equal "!", @btext.insert_into_translation_builder(["..","00","0."])
  end

  def translation_builder_line_checker
    79.times {@btext.translation_builder("a")}
    assert 79, @btext.normal_line.length
    3.times {@btext.translation_builder("a")}
    assert 2, @btext.normal_line.length
    assert 80, @btext.test_output.chomp
  end

  def test_braille_hello
    breader = NightRead.new(load_braille_hello, create_sample_txt_output_file("english_translation_test1"))
    breader.create_lines_of_braille(breader.file_input)
    assert_equal "hello", breader.test_output.chomp
  end

  def test_braille_hello_word
    breader = NightRead.new(load_braille_hello_word, create_sample_txt_output_file("english_translation_test2"))
    breader.create_lines_of_braille(breader.file_input)
    assert_equal "hello, world!", breader.test_output.chomp
  end

  def test_braille_hello_word_caps
    breader = NightRead.new(load_braille_hello_word_caps, create_sample_txt_output_file("english_translation_test3"))
    breader.create_lines_of_braille(breader.file_input)
    assert_equal "Hello, World!", breader.test_output.chomp
  end

  def test_extra_line_creation
    sym_test = NightRead.new(load_braille_symbols_letters, create_sample_txt_output_file("english_translation_test4"))
    line_array, line1, line2, line3 = sym_test.create_lines_of_braille(sym_test.file_input)
    assert_equal "00..00..0.", line1
    assert_equal ".....0...0", line2
    assert_equal "00.000.000", line3
  end

  def test_symbols_letters_caps
    a = " !',-.?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    breader = NightRead.new(load_braille_symbols_letters, create_sample_txt_output_file("english_translation_test5"))
    breader.create_lines_of_braille(breader.file_input)
    assert_equal a, breader.test_output.chomp
  end

  def test_braille_numbers
    a = "123456"
    breader = NightRead.new(load_braille_numbers, create_sample_txt_output_file("english_translation_test6"))
    breader.create_lines_of_braille(breader.file_input)
    assert_equal a, breader.test_output.chomp
  end

  def test_braille_hello_word_numbers
    a = "123456 Hello, world!"
    breader = NightRead.new(load_braille_hello_word_numbers, create_sample_txt_output_file("english_translation_test7"))
    breader.create_lines_of_braille(breader.file_input)
    assert_equal a, breader.test_output.chomp
  end

  def test_backwards
    a = "0.0.0.0.0........00.0.0.00....\n00.00.0..0..0...00.0000..0..00\n....0.0.0..0.....00.0.0....00.\n"
    @btext = NightRead.new(a, create_sample_txt_output_file("english_translation_test8"))
    @btext.create_lines_of_braille(a)
  end

  def load_braille_a
    File.open("test/test_files/braille_a.txt", "r").read
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

  def create_sample_txt_output_file(filename)
    File.open("test/output_files/#{filename}.txt", "w")
  end

  def read_sample_txt_output_file(filename)
    File.open("test/output_files/#{filename}.txt", "r").read
  end

end
