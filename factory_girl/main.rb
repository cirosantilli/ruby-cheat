#!/usr/bin/env ruby

require 'factory_girl'

##factory

  ##Minimal test

    class Min
      attr_accessor :a, :save

      def initialize
        @a = 0
        @save = -1
      end

      def save!
        @save = @a + 1
      end
    end

    FactoryGirl::define do
      factory :min do
        a 1
      end
    end

    o = FactoryGirl::create(:min)
    o.class == Min or raise
    o.a == 1 or raise

  ##create

    # Calls `save!` on the object by default.

    # Can be customized with ##to_create { |instance| instance.persist! }

    # Can be prevented with ##skip_create

    # Can be prevented on a single call with `build`.

      o.save == 2 or raise

  ##build

    # Like `create` but don't call `save!`:

      o = FactoryGirl::build(:min)
      o.a == 1 or raise
      o.save == -1 or raise

  ##Custom class name

      class OriginalName
        attr_accessor :a
      end

      FactoryGirl::define do
        factory :custom_name, class: OriginalName do
          a 1
        end
      end

      o = FactoryGirl::build(:custom_name)
      o.a == 1 or raise

  ##Redefine factory

    # Redefining a factory leads to an error.

      FactoryGirl::define do
        factory :redefined do
        end
      end

      begin
        FactoryGirl::define do
          factory :redefined do
          end
        end
      rescue FactoryGirl::DuplicateDefinitionError
      else
        raise
      end

  ##Block output

    # Passing a block to methods like create, build or stub
    # yields the instance with a limited lifetime.

      FactoryGirl::create(:min) do |o|
        o.a == 1 or raise
      end

  ##Block attribute input

    # Attribute value can also be a block. It will be lazy evaluated.

      class BlockInput
        attr_accessor :a
      end

      FactoryGirl::define do
        factory :block_input do
          a { 1 }
        end
      end

      FactoryGirl::build(:block_input).a == 1 or raise

  ##Custom attribute

    # Attributes given at build time override factory defaults.

      class CustomAttr
        attr_accessor :a, :b
      end

      FactoryGirl::define do
        factory :custom_attr do
          a 1
          b 2
        end
      end

      o = FactoryGirl::build(:custom_attr, b: 3)
      o.a == 1 or raise
      o.b == 3 or raise

  ##Association

  ##Empty attribute input

  ##Call one factory as value of the attribute of another

    # If an attribute is empty, it automatically calls another defined factory.

    # The other factory can come before or after the first one.

      class Empty
        attr_accessor :empty_other
      end

      class EmptyOther
        attr_accessor :a

        def save!
        end
      end

      FactoryGirl::define do
        factory :empty do
          empty_other
        end
      end

      FactoryGirl::define do
        factory :empty_other do
          a 1
        end
      end

      o = FactoryGirl::build(:empty)
      o.empty_other.class == EmptyOther or raise
      o.empty_other.a == 1 or raise

  ##sequence

    # Generate a new number for a field on every build call.

      class Sequence
        attr_accessor :a, :b
      end

      FactoryGirl::define do
        factory :sequence do
          sequence(:a)
          sequence(:b) {|n| "s#{n}"}
        end
      end

      o = FactoryGirl::build(:sequence)
      o.a == 1 or raise
      o.b == 's1' or raise

      o = FactoryGirl::build(:sequence)
      o.a == 2 or raise
      o.b == 's2' or raise

      o = FactoryGirl::build(:sequence)
      o.a == 3 or raise
      o.b == 's3' or raise

    # Can also be used to generate factories:

      class SequenceFactory
        attr_accessor :a, :b
      end

      class SequenceFactory2
        attr_accessor :a, :b
      end

      FactoryGirl::define do
        sequence(:a)

        # Custom sequence.
        sequence(:b) do
          [1, 2].sample
        end

        factory :sequence_factory do
          a
          b
        end

        factory :sequence_factory2 do
          a
          b
        end
      end

      o = FactoryGirl::build(:sequence_factory)
      o.a == 1 or raise
      [1, 2].include? o.b or raise

      o = FactoryGirl::build(:sequence_factory)
      o.a == 2 or raise
      [1, 2].include? o.b or raise

    # The same sequence is incremented across multiple factories:

      o = FactoryGirl::build(:sequence_factory2)
      o.a == 3 or raise
      [1, 2].include? o.b or raise

      o = FactoryGirl::build(:sequence_factory2)
      o.a == 4 or raise
      [1, 2].include? o.b or raise

  ##trait

    # Complex predefined attribute values made easy.

      class Trait
        attr_accessor :a, :b
      end

      FactoryGirl::define do
        factory :trait do
          a 1
          b 2

          trait :small do
            a -1
          end

          trait :big do
            a 10
            b 20
          end
        end
      end

      o = FactoryGirl::build(:trait)
      o.a == 1 or raise
      o.b == 2 or raise

      o = FactoryGirl::build(:trait, :small)
      o.a == -1 or raise
      o.b == 2 or raise

      o = FactoryGirl::build(:trait, :big)
      o.a == 10 or raise
      o.b == 20 or raise

    # Build time parameters win:

      o = FactoryGirl::build(:trait, :big, a:3)
      o.a == 3 or raise
      o.b == 20 or raise

    # Last trait wins:

      FactoryGirl::build(:trait, :small, :big).a == 10 or raise
      FactoryGirl::build(:trait, :big, :small).a == -1 or raise

##build_stubbed

  # TODO Returns an object with all defined attributes stubbed out

    #stub = build_stubbed(:user)
