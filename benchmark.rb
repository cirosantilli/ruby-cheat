#!/usr/bin/env ruby

require 'benchmark'

N = 10000

##bm

    # Must be at least as large as the longest description.
    first_col_width = 16

    Benchmark.bm(first_col_width) do |benchmark|
      benchmark.report('+= [0]') do
        a = []
        N.times { a += [0] }
      end

      benchmark.report('<< 0') do
        a = []
        N.times { a << 0 }
      end

      benchmark.report('<< [0, 1]') do
        a = []
        N.times { a += [0, 1] }
      end

      benchmark.report('push(*[0, 1])') do
        a = []
        N.times { a.push(*[0, 1]) }
      end

      benchmark.report('concatenate') do
        a = []
        N.times { a.concat([0, 1]) }
      end

      benchmark.report('+= "ab"') do
        a = ''
        N.times { a += 'ab' }
      end

      benchmark.report('<< "ab"') do
        a = []
        N.times { a << 'ab' }
      end
    end

##bmbm

  # Run benchmark twice to minimize garbage collection instability effects.

  # Always use it.
