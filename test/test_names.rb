require 'minitest_helper'

class NamesTestClass < Minitest::Test
  def test_names_tc1
    p "names_tc1"
    pass
  end
  def test_names_tc2
    p "names_tc2"
    pass
  end
end

Minitest::Runnable.runnables.delete(NamesTestClass)

class TestNames < Minitest::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil MiniTest::Names::VERSION
  end

  def test_run_single_test
    args = ['-v', '--names=names_tc1']
    exp = ['names_tc1']
    assert_test_names args, exp
  end

  private

  def assert_test_names args, expected
    options = Minitest.process_args args
    Minitest.plugin_names_init(options)
    assert_equal expected, options[:filter]
  end

end
