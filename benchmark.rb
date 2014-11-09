#!/usr/bin/env ruby

# How to use the benchmark library + some interesting benchmarks
# of the language and stdlib.

require 'benchmark'

N = 10000

##bm

    # Must be at least as large as the longest description.
    first_col_width = 16

    Benchmark.bm(first_col_width) do |benchmark|

      # In place vs create new benchmarks:

        # TODO why does it take forever with f = 10?
        f = 1

        benchmark.report('+= [0]') do
          a = []
          (f*N).times { a += [0] }
        end

        benchmark.report('<< 0') do
          a = []
          (f*N).times { a << 0 }
        end

        benchmark.report('<< [0, 1]') do
          a = []
          (f*N).times { a += [0, 1] }
        end

        f = 100

        benchmark.report('push(*[0, 1])') do
          a = []
          (f*N).times { a.push(*[0, 1]) }
        end

        benchmark.report('concatenate') do
          a = []
          (f*N).times { a.concat([0, 1]) }
        end

        f = 10

        benchmark.report('+= "ab"') do
          a = ''
          (f*N).times { a += 'ab' }
        end

        benchmark.report('<< "ab"') do
          a = []
          (f*N).times { a << 'ab' }
        end

      # Regex vs String methods:

        f = 100

        benchmark.report('match(/b$/)') do
          (f*N).times { 'ab'.match(/b$/) }
        end

        benchmark.report('end_with?(b)') do
          (f*N).times { 'ab'.end_with?('b') }
        end

      # String vs Symbol:

        f = 100

        benchmark.report("'abcd' == 'abcd'") do
          (f*N).times { 'abcd' == 'abcd' }
        end

        benchmark.report(':abcd == :abcd') do
          (f*N).times { :abcd == :abcd }
        end
    end

##bmbm

  # Run benchmark twice to minimize garbage collection instability effects.

  # Always use it.
