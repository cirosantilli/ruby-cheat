#!/usr/bin/env ruby
# In the Ruby stdlib, but source still
# maintained separatelly at: <https://github.com/seattlerb/minitest>

# This is required to run the tests automatically.
require 'minitest/autorun'

# Like everything in Ruby, there are two ways to do tests:
# Minitest::Unit, and Minitest::Spec.
# Unit is sane, Spec is a copy of RSpec and thus insane.

DO_FAIL = false

##Unit

  # Every descentant of MiniTest::Unit::TestCase is run at the end.

  # Some method names are magic:

  # - every test starts with `test_`
  # - setup
  # - teardown

    class TestTest < MiniTest::Test
      def setup
        @a = 0
      end

      #def teardown
        #@a = 0
      #end

      def after_run
        puts 'asdf'
      end

      def test_fails
        if DO_FAIL
          assert false
        end
      end

      ##Error

        # Failures are distinguished from errors on the output
        #
        # Both are exceptions, but Failures are exceptions derived from
        # MiniTest::Assertion and all others are errors.
        #
        # There are also a few exceptions which are ignored, such as
        # interrupt exceptions to allow stoping the tests.

          def test_error
            if DO_FAIL
              raise
            end
          end

          def test_fails_explicit_raise
            if DO_FAIL
              raise MiniTest::Assertion
            end
          end

          def test_fails_explicit_raise
            if DO_FAIL
              raise Interrupt
            end
          end

      def test_instance_var
        assert_equal @a, 0
      end

      ##assertions
      def test_assertions
        assert_raises(Exception) {raise Exception}
        # TODO assert raises descendant?
        # TODO refute raises?
      end
    end

  # TODO how to run something before / after the entire suite?

##Spec

  # TODO

##stub

  # Replace a method of an object with another while temporarily.

    class StubTest < MiniTest::Test
      def test_stub
        a = []
        a.stub(:push, 1) do
          # The stubbed method can be called any number of times
          # with any arguments. The return is always the same fixed value.
          assert_equal(a.push, 1)
          assert_equal(a.push(0), 1)
          assert_equal(a.push(0, 1), 1)
        end
        # The methoe really is completelly replaced
        # and side-effects do not happen.
        assert_equal(a, [])
      end
    end

##Mock

  # Create objects to replace other objects.

    class MockTest < MiniTest::Test

      ##expect
      #
      # Quickly add a method with a given return value to the created mock.
      def test_expect
        m = MiniTest::Mock.new
        m.expect(:new_method, 1)
        m.expect(:new_method, 2)
        assert_equal(m.new_method, 1)
        assert_equal(m.new_method, 2)

        # Once all method calls have been consumed,
        # verify is true.
        assert(m.verify)

        # Every time the method is called an expect is consumed:
        # when there are not more, it raises.
        assert_raises(MockExpectationError) { m.new_method }
      end

      def test_expect_args
        m = MiniTest::Mock.new
        m.expect(:new_method, 1, [0, 1])
        m.expect(:new_method, 2, [2, 3])
        assert_equal(m.new_method(0, 1), 1)
        assert_equal(m.new_method(2, 3), 2)
        m.verify
      end

      def test_expect_wrong_args
        m = MiniTest::Mock.new
        m.expect(:new_method, 1, [0, 1])
        # Args must match excatly what was expected or error.
        assert_raises(MockExpectationError) { m.new_method(0, 2) }
      end

      def test_verify_raises
        m = MiniTest::Mock.new
        m.expect(:new_method, 0)

        # If there are mocks missing, verify raises.
        assert_raises(MockExpectationError) { m.verify }
      end
    end

##Benchmarks

  # This module can also do benchmarks, in particular assert function complexity
  # by running various input sizes and matching curves (linear, log, etc.).

  # Note that there is also a Benchmark class on the Ruby stdlib.

    require 'minitest/benchmark'

    class TestBenchmark < MiniTest::Test
      def linear_algo(n)
        Array.new(n, 0).map { |x| x + 1 }
      end

      def test_linear_algo
        # TODO how to get this working?
        #assert_performance_linear do |n|
          #linear_algo(n)
        #end
      end
    end

##pride

  # Joke only module that makes tests colorful like a rainbow.

  # Not useful for debugging though.

    #require 'minitest/pride'
