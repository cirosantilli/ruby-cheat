DO_FAIL = true

class Spinach::Features::FeatureOne < Spinach::FeatureSteps
  step 'f' do
    Testee.new.f == 0 or raise
  end

  step 'background set' do
    @a = 0
  end

  step 'background test' do
    assert_equal(@a, 0)
  end

  # Indicates that the test is yet to be written.
  step 'pending test' do
    pending('msg')
  end

  step 'fail' do
    if DO_FAIL
      assert(false)
    end
  end

  # Like Minitest itself, Spinach differentiates between errors and failures:
  # by only considering exceptions derived from certain base classes to be failures
  # (MiniTest::Assertion, rspec failure base class), so you can use either of
  # MiniTest assertions or RSpec assertions.

    step 'error' do
      if DO_FAIL
        raise
      end
    end

    step 'explicit fail' do
      if DO_FAIL
        raise(MiniTest::Assertion)
      end
    end
end
