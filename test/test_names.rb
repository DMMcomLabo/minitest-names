require 'minitest_helper'
require 'stringio'

class TestNames < Minitest::Unit::TestCase

  def setup
    @tc1 = Class.new Minitest::Test do
      define_method :test_say_hello do
        pass
      end
      define_method :test_say_kiaora do
        pass
      end
      define_method :test_say_goodbye do
        assert false
      end
    end

    @tc2 = Class.new Minitest::Test do
      define_method :test_say_hello do
        pass
      end
    end
  end

  def test_that_it_has_a_version_number
    refute_nil MiniTest::Names::VERSION
  end

  def test_run_test_by_names
    args = ['--names', 'test_say_goodbye']
    options = Minitest.process_args args

    Object.const_set(:Hello1, @tc1)

    tcs = [@tc1]

    expected = {
      :count => 1,
      :failures => 1,
      :filter => ['test_say_goodbye']
    }
    result = run_test options, tcs
    assert_result expected, result
  ensure
    Object.send :remove_const, :Hello1
  end

  def test_run_tests_by_names
    args = ['--names', 'test_say_hello, test_say_kiaora']
    options = Minitest.process_args args

    Object.const_set(:Hello1, @tc1)

    tcs = [@tc1]

    expected = {
      :count => 2,
      :failures => 0,
      :filter => ['test_say_hello', 'test_say_kiaora']
    }
    result = run_test options, tcs
    assert_result expected, result
  ensure
    Object.send :remove_const, :Hello1
  end

  def test_run_tests_by_name
    args = ['--names', 'test_say_hello']
    options = Minitest.process_args args

    Object.const_set(:Hello1, @tc1)
    Object.const_set(:Hello2, @tc2)

    tcs = [@tc1, @tc2]

    expected = {
      :count => 2,
      :failures => 0,
      :filter => ['test_say_hello']
    }
    result = run_test options, tcs
    assert_result expected, result
  ensure
    Object.send :remove_const, :Hello1
    Object.send :remove_const, :Hello2
  end

  private

  def run_test options, tcs
    Minitest.plugin_names_init(options)

    output = StringIO.new
    reporter = Minitest::CompositeReporter.new
    reporter << Minitest::SummaryReporter.new(output, options)
    reporter << Minitest::ProgressReporter.new(output, options)

    reporter.start

    tcs.each do |tc|
      Minitest::Runnable.runnables.delete tc
      tc.run reporter, options
    end

    reporter.report[0]
  end

  def assert_result expected, actual
    assert_equal expected[:count], actual.count
    assert_equal expected[:failures], actual.failures
    assert_equal expected[:filter], actual.options[:filter]
  end
end
