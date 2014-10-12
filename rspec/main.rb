#!/usr/bin/env ruby

# With this, you don't need to do `rspec main.rb`:
# you can just do `ruby main.rb` and tests will be run.
# It requires RSpec itself.
require 'rspec/autorun'

require_relative 'testee'

do_fail = false

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

    # Can impact tests:

    # - with rspec-rails controller tests, the controller is taken from describe

    # Any object can be passed to describe, and the class being tested is often passed.

  ##it

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

  it '##expect ##to' do

    # Replaces should on 2.11. Should be used instead of should.
    # Less insane than `should`, but still insaner than Minitest asserts.

    ##eq

      # Calls `==`.

        expect(1).to eq(1)
        if do_fail
          expect(1).to eq(2)
        end

      # You should not use `==` with expect to. It might work but is bad.

        if do_fail
          expect(1).to == 1
        end

    ##define a matcher

        RSpec::Matchers.define :be_eq do |expected|
          match do |actual|
            actual == expected
          end
        end

        expect(1).to be_eq(1)
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

    # Vs instance variables: <http://stackoverflow.com/questions/5359558/when-to-use-rspec-let>

      let(:a) { 0 }

      it 'eq 0' do
        expect(a).to eq(0)
        a = 1
      end

      it 'eq 1' do
        expect(a).to eq(0)
      end
  end

  ##Real usage example

    # This is how you would test a real library.

      describe Testee do
        it 'has method' do
          expect(Testee.new.method).to eq(0)
        end
      end

  describe '##double' do
    it 'TODO' do
    end
  end
end
