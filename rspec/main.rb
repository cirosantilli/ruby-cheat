#!/usr/bin/env ruby

# With this, you don't need to do `rspec main.rb`:
# you can just do `ruby main.rb` and tests will be run.
# It requires RSpec itself.
require 'rspec/autorun'

require_relative 'testee'

do_fail = false
#do_fail = true

$before_suite = 0
$after_suite = 0

RSpec.configure do |config|
  config.before(:suite) do
    $before_suite = 1
    @before_suite = 1

    # To abort tests, you can raise here.
    # Note however that config.after(:suite) will still run.
    # Try uncommenting the raise 'b' on `after(:suite)` to see this.
    #raise 'a'
  end

  config.after(:suite) do
    $after_suite = 1
    @after_suite = 1

    #raise 'b'
  end

  # Run once before every toplevel describe.
  config.before(:all) do
    #raise 'a'
  end

  #config.after(:all) do
    #raise 'b'
  #end
end

RSpec.describe 'desc0' do

  ##describe

    # https://www.relishapp.com/rspec/rspec-core/v/3-1/docs/example-groups/shared-examples

    # The argument can impact tests

    # - `subject` is implicitly set as the argument, and `is_expected` referenes it
    # - with rspec-rails controller tests, the controller is taken from describe

    # Any object can be passed to describe, and the class being tested is often passed.

  ##it

    # https://www.relishapp.com/rspec/rspec-core/v/3-1/docs/example-groups/shared-examples

    # Basic test unit.

    # The test fails if one should or expect to inside it fails.

      describe 'desc0_0' do
        it 'passes' do
        end

        it 'passes' do
          expect(1).to eq(1)
        end

    ##pending

      # Mark a known failure.

      # Appears as pending on the output, separately from failures.

      # Pending tests must fail: if not they become errors.

        it 'fails', pending: true do
          expect(1).to eq(2)
        end

    ##context

      # Alias to `describe`.

      # Some use both where each word makes more sense.

      # I think it is just more duplicity insanity: burninate context.

        context 'some context' do
          it 'it inside context' do
            expect(1).to eq(1)
          end
        end

    ##Programatically define tests

        [0, 1].each do |i|
          it "got defined #{i}" do
            expect(1).to eq(1)
          end
        end
  end

  it '##should' do
    # Old and discoraged. Raises deprecation warning Use expect to instead.
    # https://github.com/rspec/rspec-expectations/blob/8c553c24133b794c3cf62ad15349531827db3db5/Should.md
    # Insaner because method monkey patched into every object.

      if false
        1.should eq(1)
        if do_fail
          1.should eq(2)
        end
      end
  end

  describe '##expect ##to' do

    # Part of the <https://github.com/rspec/rspec-expectations> submodule

    # Replaces should on 2.11. Should be used instead of should.

    # Less insane than `should` since no monkey patch,
    # but still insaner than Minitest asserts.

    it '##eq' do

      # Calls `==`.

        expect(1).to eq(1)
        if do_fail
          expect(1).to eq(2)
        end

      # You should not use `==` with expect to. It might work but is bad.

        if do_fail
          expect(1).to == 1
        end
    end

    it '##raise' do
      # Raise any exception.

        (expect { 0 }).not_to raise_error
        (expect { raise }).to raise_error

        if do_fail
          (expect { raise }).not_to raise_error
        end

      # RSpec forbids you from doing `not_to raise_error(argument)`:
      # you must use `not_to raise_error` without argument (TODO why?)

        #(expect { raise Exception }).not_to raise_error(RuntimeError)

      # Base classes are also caught unlike in Minitest's `assert_raise`.

        (expect { raise RuntimeError }).to raise_error(Exception)

      # If the argument is a string, catch by message:

        (expect { raise Exception.new('abc') }).to raise_error('abc')
    end

    it '##Automatically defined matchers' do

      # More insanity in the name of readability.

      # Matchers of the form `have_x` are automatically converted to `.has_x?` methods:

        expect(Testee.new).to have_x

      # Matchers of the form `be_x` are converted to `x?`:

        expect(Testee.new).to be_x

      # For this reason you should seldom use `be_true` or `be_false`:
      # add a `has_X?` or `X?` method to the class and use automatic matchers.
    end

    it '##Create a new matcher' do
        RSpec::Matchers.define :new_eq do |expected|
          match do |actual|
            actual == expected
          end
        end

        expect(1).to new_eq(1)
    end
  end

  describe '##before ##after' do

    # Before and after can be used here just like in the spec_helper
    # but scoped to the current describe.

    # Does not need to come before the tests, although it is obviously
    # the sanest thing to do.

      it 'i == 0' do
        expect(@i).to eq(0)
        (expect { i }).to raise_error(NameError)
        @i = 1
      end

      before(:each) do
        @i = 0
        i = 0
      end

      it 'i == 0' do
        expect(@i).to eq(0)
      end

      it '##before(:suite)' do
        expect($before_suite).to eq(1)
        expect($after_suite).to eq(0)

        # Instance variables not supported.
        # The best workaround seems to be to write to a file.
        # Sample application: start a server before suite,
        # save it's PID, stop after suite.
        # https://github.com/resque/resque/wiki/RSpec-and-Resque
        expect(@before_suite).to eq(nil)
        expect(@after_suite).to eq(nil)
      end
  end

  describe '##let' do

    # Define certain variables before each test.
    # They are not persistent across tests.

    # The result is memoized after the first run, so that:
    #
    # - if a database query is run to create the object, it is only run once
    # - if the object is not used in a test it costs nothing

    # Vs instance variables: <http://stackoverflow.com/questions/5359558/when-to-use-rspec-let>

      let(:a) { [] }

      it 'eq 0' do
        expect(a).to eq([])

        a << 0
        expect(a).to eq([0])
      end

      describe 'memoize' do
        let(:time) { Time.now }

        it 'is memoized' do
          last_time = time
          # If the block were run every time,
          # there would be some time ellapsed between the last statement.
          expect(last_time).to eq(time)
        end
      end
  end

  describe '##subject' do

    # See also: `described_class`.

    it 'is taken directly from the innermost describe if it is not a class object' do
      expect(subject).to eq('##subject')
    end

    describe Array do
      it 'is an instance of the innermost describe if it is a class object' do
        expect(subject).to eq([])
      end
    end

    describe 'set' do
      it 'can be explicitly set for the entire block' do
        is_expected.to eq(0)
      end

      subject { 0 }
    end

    describe 'set works with block and let' do
      let(:a) { [] }
      subject { a.length }

      it 'really does' do
        is_expected.to eq(0)
        a << 1
        # TODO why?
        is_expected.to eq(0)
      end
    end

    describe '##is_expected' do
      it 'wraps expect(subject).to' do
        is_expected.to eq('##is_expected')
      end
    end
  end

  describe '##double' do
    it 'TODO' do
    end
  end

  ##Real usage example

    # This is how you would test a real library.

      describe Testee do
        it 'has method' do
          expect(Testee.new.method).to eq(0)
        end
      end

end

##described_class

    RSpec.describe Array do
      describe String do
        it 'equals the innermost described object' do
          expect(described_class).to eq(String)
        end
      end
    end

  # Same if it is not a Class object.

    RSpec.describe String do
      describe 0 do
        it 'a' do
          expect(described_class).to eq(0)
        end
      end
    end

##shared_examples

  # https://www.relishapp.com/rspec/rspec-core/v/3-1/docs/example-groups/shared-examples

  # Insert given tests at multiple locations.

  ##it_behaves_like

    RSpec.shared_examples '0 or 1' do
      it 'is either 0 or 1' do
        expect([0, 1]).to be_include(subject)
      end
    end

    RSpec.describe 0 do
      it_behaves_like '0 or 1'
    end

    RSpec.describe 1 do
      it_behaves_like '0 or 1'
    end

  ##include_examples

  ##should_behave_like

    # <http://stackoverflow.com/questions/19556296/whats-the-difference-between-include-examples-and-it-behaves-like>

    # TODO alias to `it_behaves_like`?

      RSpec.describe 0 do
        include_examples '0 or 1'
      end

      RSpec.describe 1 do
        include_examples '0 or 1'
      end

      if do_fail
        RSpec.describe 2 do
          include_examples '0 or 1'
        end
      end

  # Helpers, `let`, can be overridden on derived tests.

    RSpec.shared_examples 'helper eq 1' do
      it 'helper eq 1' do
        expect(helper).to eq(1)
      end

      def helper
        0
      end
    end

    if do_fail
      RSpec.describe 0 do
        include_examples 'helper eq 1'
      end
    end

    RSpec.describe 1 do
      include_examples 'helper eq 1'

      def helper
        1
      end
    end

##shared_context

  # https://www.relishapp.com/rspec/rspec-core/v/3-1/docs/example-groups/shared-context

  # Similar to `shared_examples`, but only used to share context like
  # `before` hooks, `let`, `subject` or helpers.
