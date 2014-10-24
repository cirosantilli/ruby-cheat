# Spinach

Unit testing framework, with yet another super mini-language:
the Gherkin language, not even a ruby DSL.
It seems that the goal of that language is to make tests accessible,
specially to people who do not understand Ruby.

This leads to tons of duplication and verbose test names.

## Test organization

Everything goes under the `feature` directory.

Standard configuration file is `/features/support/env.rb`.

Feature file `feature_name.feature` contains:

    Feature: Feature Name

      Scenario: Anything goes
        Given Step name

Steps are defined at `steps/any_name.rb` (by convention `steps/feature_name.rb`) as

    class Spinach::Features::FeatureOne < Spinach::FeatureSteps
      step 'Step name' do
      end
    end

The class name *must* match the feature name converted to camel case.

## CLI interface

Run all tests under `/feature`:

    spinach

Run a single test file:

    spinach features/path/file.feature

Run a single test at given line:

    spinach features/path/file.feature:123
