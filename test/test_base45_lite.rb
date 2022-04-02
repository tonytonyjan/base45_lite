# frozen_string_literal: true

require 'minitest/autorun'
require 'base45_lite'

class TestBase45Lite < Minitest::Test
  parallelize_me!

  def test_encode
    assert_equal 'BB8', Base45Lite.encode('AB')
    assert_equal '%69 VD92EX0', Base45Lite.encode('Hello!!')
    assert_equal 'UJCLQE7W581', Base45Lite.encode('base-45')
  end

  def test_decode
    assert_equal 'ietf!', Base45Lite.decode('QED8WEX0')
    assert_equal 'AB', Base45Lite.decode('BB8')
    assert_equal 'Hello!!', Base45Lite.decode('%69 VD92EX0')
    assert_equal 'base-45', Base45Lite.decode('UJCLQE7W581')
  end

  def test_raise_invalid_character_error
    assert_raises(Base45Lite::InvalidCharacterError) { Base45Lite.decode('^{}[]!&') }
  end

  def test_raise_overflow_error
    assert_raises(Base45Lite::OverflowError) { Base45Lite.decode('///') }
  end

  def test_raise_forbidden_length_error
    assert_raises(Base45Lite::ForbiddenLengthError) { Base45Lite.decode('ABCD') }
  end
end
