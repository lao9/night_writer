require "minitest"
require "minitest/pride"
require "minitest/autorun"
require "../night_writer/lib/night_write"

class NightWriteTest < Minitest::Test
  attr_reader :braille_write

  def setup
    @braille_write = NightWrite.new
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
end
