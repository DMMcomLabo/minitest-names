require 'minitest_helper'

class TestNames < MiniTest::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil MiniTest::Names::VERSION
  end

  def test_respond_public_method
    assert MiniTest::Names.respond_to?(:test_with_names)
  end
end
