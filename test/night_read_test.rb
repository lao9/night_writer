require "minitest"
require "minitest/pride"
require "minitest/autorun"
require "../night_writer/lib/night_read"
require "pry"

class NightReadTest < Minitest::Test
  attr_reader :btext
  def setup
    @btext = NightRead.new
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

end
