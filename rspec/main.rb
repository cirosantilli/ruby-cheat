#!/usr/bin/env ruby

require_relative 'testee'

do_fail = true

##describe

  # TODO can impact tests, or is it string description only?

  # Any object can be passed to describe, and the class being tested is often passed.

##it

  # Basic test unit.

  # The test fails if one should or expect to inside it fails.

RSpec.describe 'desc0' do
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
  end

  describe 'abc' do
    #it { should == 'abc' }
    #it { should != 'acb' }
  end

  it '##should' do
    # Old and discoraged. Use expect to instead.
    # https://github.com/rspec/rspec-expectations/blob/8c553c24133b794c3cf62ad15349531827db3db5/Should.md

    # Insaner because method monkey patched into every object.

      1.should eq(1)
      if do_fail
        1.should eq(2)
      end
  end

  it 'expect' do

    # Replaces should. Less insane, but still insaner than Minitest asserts.

    ##eq

      # Calls `==`.

        expect(1).to eq(1)
        if do_fail
          expect(1).to eq(2)
        end

      # Cannot use operators with expect to:

        if do_fail
          expect(1).to == 1
        end

    ##be

      # TODO what does it do exactly? Seems to work for operators.

        expect(1).to be == 1

    ##define a matcher

        RSpec::Matchers.define :be_eq do |expected|
          match do |actual|
            actual == expected
          end
        end

        expect(1).to be_eq(1)
  end

  ##before ##after

    # Before and after can be used here just like in the spec_helper
    # but scoped to a single describe.

      before(:each) do
        @i = 0
      end

      it 'i == 0' do
        expect(@i).to eq(0)
        @i = 1
      end

      it 'i == 0' do
        expect(@i).to eq(0)
      end

  describe Testee do
    it 'has method' do
      expect(Testee.new.method).to eq(0)
    end
  end
end
