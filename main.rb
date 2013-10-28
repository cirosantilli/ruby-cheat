#!/usr/bin/env ruby

##comments

    # Multiline comments:

=begin a
    multi
    line comment
=end

    # `=` Must be the first thing on the line. The following would be a syntax error:

        #=begin
        #=end

##spaces

    # Indentation is not mandatory:

        true
            true
    true

    # Newlines dispense semicolon `;`
    # Semicolon `;` needed for multiple statements on a single line.

        1 + 1; 1 + 1

    # If a `+` is encountered at the end of line, then the line continues:

        1 +
        1 == 2 or raise

    # Spaces may disambiguate certain statements. See function

##identifier chars

    # Most of the rules are like for C: `a-zA-Z0-9_`, not start in `0-9`, canse sensitive.

    # But:

    # - method names can end in `?`, `!` or `=`. This has no syntatical value,
    #   but each has a very well defined and followed convention.

    # - variable names that start with an Upper case letter are considered constants..
    #   Attempting to modify them leads to a warning by default.

            ii = 0
            ii = 1

            # Ok: definition
            Ii = 0
            # Warning: modifying constant
            #Ii = 1

    # - class names must start with an upper case character, or an error is generated.

        # Error:

            #class c end

##built-in variables

        puts("RUBY_VERSION = #{RUBY_VERSION}")
        puts("RUBY_PATCHLEVEL = #{RUBY_PATCHLEVEL}")
        puts("__FILE__ = #{__FILE__}")
        puts("__LINE__ = #{__LINE__}")

##string

    ##quoting

        # Single or double quotes can be used with the difference that with single quotes:

        # - backslash escapes are not interpreted
        # - format strings are not interpreted

        ##arbitrary delimier

            # The percent allows to use any delimier character:

                'a' == %<a> or raise
                'a' == %!a! or raise

            # Must be an special char:

                #'a' == %bab or raise

            # `q` is optional. Other modifiers exist:

            # - `Q` for double quoted
            # - `x` for backtick executes

                s = 'a'
                '#{s}' == %q!#{s}! or raise
                "#{s}" == %Q!#{s}! or raise
                %x<ruby -e "print 1"> == '1' or raise

    # Concatenate:

        'a' + 'b' == 'ab' or raise

    ##format

            s = 'bc'
            "a#{s}d" == 'abcd' or raise

        # Only works for double quoted strings:

            s = 'a'
            '#{s}' == '#' + '{s}' or raise

        # Arbitrary delimier:

            s = "a"
            '#{s}' == '#' + '{s}' or raise

        # Escape:

            s = 'a'
            "\#{s}" == '#' + '{s}' or raise

        # Brackets required:

            s = 'a'
            "#s" == '#s' or raise

        # Brackets not required for class variables:

            class C
                @@i = 0
                def initialize()
                    @i = 1
                end
                def method()
                    "#@@i#@i"
                end
            end
            c = C.new()
            c.method() == "01" or raise

        # Anything can be formatted (TODO what does it have to implement?)

            "#{1}"          == '1' or raise
            "#{[1, 2, 3]}"  == '[1, 2, 3]' or raise
            "#{1..3}"       == '1..3' or raise
            h = {1=>'one', 2=>'two'}
            "#{h}"          == '{1=>"one", 2=>"two"}' or raise

    ##heredoc

        s = <<EOF
a
b
EOF
        s == "a\nb\n" or raise

        s = <<ANY_STRING_OK
a
ANY_STRING_OK

        s == "a\n" or raise

##list

    # See array.

##array

    # Contains any number of objects of any type.

        is = [0, 'a', 'abc']
        is[0] == 0 or raise
        is[1] == 'a' or raise

    # Also possible to create via explicit constructor:

        Array.new == [] or raise
        Array.new(3) == [nil, nil, nil] or raise
        Array.new(3, true) == [true, true, true] or raise

    # Array to string:

        ['ab', 'cd'].join(' ') == 'ab cd' or raise

    # Special syntax for an array of strings literal:

        ss = %w{ ab cd ef }
        ss[0] == 'ab' or raise
        ss[1] == 'cd' or raise

##range

    # Different from Array.

        r = 1..3

    # Error: no [] operator
    #r[1] == 2

    # Convert to array:

        (1..3).to_a == [1, 2, 3] or raise

    # Triple dot excludes end:

        (1...3).to_a == [1, 2] or raise

    # Possible on chars and strings:

        ('a'..'c').to_a == ['a', 'b', 'c'] or raise
        ('aa'..'ac').to_a == ['aa', 'ab', 'ac'] or raise

    # Range test:

        (1..3) === 2 or raise
        (1..3) != 2 or raise

    # Not reflexive:

        not 2 === (1..3) or raise

##map

    # See hash.

##hash

        m = {1=>'one', 2=>'two'}
        m[1] == 'one' or raise
        m[2] == 'two' or raise

    ##hash foreach iteration

        # Iteration order: random in 1.8, same as literal in 1.9.

            m = {2=>'two', 1=>'one'}
            keys = [2, 1]
            i = 0
            m.each do |k, v|
                if RUBY_VERSION >= '1.9'
                    k == keys[i] or raise
                end
                m[k] == v or raise
                i += 1
            end

##operators

    ##defined?

            not defined? not_yet_defined or raise
            not_yet_defined = 1
            defined? not_yet_defined or raise

##loops

    ##for in loop

        #is = (1..3)
        #j = 0
        #(1..3).each do |i|
            #is[j] == i or raise
            #j += 1
        #end

##function

    ##return value

        # Like in Perl, is the value of the last statement.

    ##multiple return values

            i, j = 1, 2
            i == 1 or raise
            j == 2 or raise

            i, j = 0, 0
            def f()
                return 1, 2
            end
            i, j = f()
            i == 1 or raise
            j == 2 or raise

        # TODO why syntax error:

            #1, 2

    ##definition

        # Parenthesis are not mandatory.

        # However, for the sake of sanity, use them always!

            def f
                1
            end
            f() == 1 or raise

            def f()
                1
            end
            f() == 1 or raise

            def f i
                i
            end
            f(1) == 1 or raise

            def f(i)
                i
            end
            f(1) == 1 or raise

            def f i, j
                i + j
            end
            f(1, 1) == 2 or raise

            def f i = 1, j = 2
                i + j
            end
            f() == 3 or raise

    ##call

        # Parenthesis are optional if no ambiguity is created.

        # For the sake of 

            def f(i, j)
                i + j
            end

            f(1, 1) == 2 or raise

        # This fails. TODO why:

        #f 1, 1 == 2 or raise

    ##parenthesis omission ambiguity

        # Calls without parenthesis could lead to potential ambiguities.

        # Never use them.

        # Spaces can determine the call behvaiour in those case.

            def f(i=1)
                i
            end

            f-1 == f() - 1 or raise

            f -1 == f(-1) or raise

    ##allowed characters

        # Besides the usual alphanumeric characters,
        # the last character of a method name can also be either a question mark `?`
        # bang `!` or equals sign `=`.

        # `?` and `!` have no syntaxical value, and their meaning is
        # fixed by convention only. `=` also has a slight sintaxical meaning.

        # ?: the method returns True or False. It queries the state of an object.

            $i = 0
            def zero?()
                $i == 0
            end

            zero?() or raise

        # !: this is the in-place version of a method.

            def inc()
                $i + 1
            end

            def inc!()
                $i += 1
            end

            $i = 0
            inc() == 1
            $i == 0
            inc!() == 1
            $i == 1

        # =: indicates a set method, specially to differenciate from the get method.

            class EqualSuffix
                def initialize(i)
                    @int = i
                end
                def int()
                    @int
                end
                def int=(i)
                    @int = i
                end
            end

            o = EqualSuffix.new(1)
            o.int() == 1 or raise
            o.int=(2)
            o.int() == 2 or raise

        # `=` gives the method a new possible setter syntax:

            o.int = 3
            o.int() == 3 or raise

    ##global variable

            $i = 1
            i = 2
            $i == 1 or raise

            $i = 1
            def f()
                $i
            end
            f() == $i or raise

            $i = 1
            def f()
                $i = 2
            end
            f()
            $i == 2 or raise

            i = 1
            def f()
                $i = 2
            end
            f()
            i == 1 or raise

            i = 1
            def f()
                i
            end
            # Error: `i` undefined.
            #f()

##class

    # Everyting is an object, including integers and floats:

        1.class   == Fixnum or raise
        1.object_id
        1.1.class == Float  or raise
        nil.class == NilClass  or raise
        nil.object_id

    # Define a class:

        class C

            @@class_i = 1

            def initialize(i)
                @member_i = i
            end

            def method()
                # Call another method of the instance:

                    self.method2() == 2 or raise

                # Access an instance variable:

                    @member_i
            end

            def method2()
                2
            end

            def C.class_method()
                1
            end

        end

        c = C.new(1)
        c.method() == 1 or raise

    # Error: it is simply not possible to access instance members directly:

        #c.member_i == 1 or raise
        #c.@member_i == 1 or raise

    # Unlike Python, classes are not namespaces and the following are errors:

        #c.not_a_member = 2
        #c.@not_a_member = 2

    ##class method

            C.class_method() == 1 or raise

        # Error: cannot access class methods or members directly from instances:

            #c.class_method() == 1 or raise
            #c.class_i == 1 or raise

    # Operator overload:

        class OperatorOverload
            def +(i)
                2
            end
        end

        OperatorOverload.new() + OperatorOverload.new() == 2

    ##inheritance

            class Base
                def base_method()
                    return 1
                end
            end

            class Derived < Base
                def derived_method()
                    return 2
                end
            end

            d = Derived.new()

    ##reflection

            class ReflectionBase
                def m_base()
                end
            end

            class ReflectionDerived < ReflectionBase
                def ReflectionDerived.c()
                end

                def m()
                end
            end

        # class:

            ReflectionDerived.new().class == ReflectionDerived
            ReflectionDerived.class == Class

        # Too verbose:

            #puts ReflectionDerived.methods.sort
            #puts ReflectionDerived.instance_methods

        # Exclude inherited methods:

            puts "instance_methods = "
            puts ReflectionDerived.instance_methods(false).sort

##module

    # Modules are namespaces.

        module M

            def M.f()
                1
            end

            class C
                def f()
                    1
                end
            end

            # Error: must be uppercase:
            #class c
            #end

            i = 1
            I = 2
            # Error:
            #M.i = 3
            #M.I = 3

        end

        M.f() == 1 or raise
        M::f() == 1 or raise

        #M.C.new().f == 1 or raise
        M::C.new().f == 1 or raise

    # Dot `.` and double colon `:` are the same execpt for constants,
    # in which case only the semicolon works if the constant starts with upper case.

        #M.i == 1 or raise
        #M.I == 1 or raise
        #M::i == 2 or raise
        M::I == 2 or raise
        # Warning: modifying already initialized constant.
        #M::I = 3

    # Error: cannot add variables to the module after its creation:

        #M.j = 1

    # Can add new functions to the module after its creation:

        module M
            def M.g()
                1
            end
        end
        M.f() == 1 or raise
        M.g() == 1 or raise

    ##include

        # Inheritance like effect with modules.

##block

    # Implement iterators.

        $i = 0
        def f()
            yield()
            yield()
        end
        f() { $i += 1 }
        $i == 2 or raise

    # Pass values:

        $i = 0
        def f(i, j)
            yield(i, j)
            yield(i, j)
        end
        f(1, 2) { |i, j| $i += i * j }
        $i == 4 or raise

    # Get values:

        $i = 0
        def f()
            $i += yield()
            $i += yield()
        end
        f() { 1 }
        $i == 2 or raise

##require

    # Error: require does not look under current dir starting from 1.9.2.
    # Use require_relative for that.

        #require 'main2'

        puts('require search path:')
        puts($:)

##require_relative

        require_relative 'main2'

        Main2.f() == 1 or raise
        AnyName.f() == 1 or raise

    # Cannot access variables:

        #main2.i == 1

##math

        Math.sqrt(9) == 3 or raise

##command line arguments

    ##global variables

            puts $0
            puts $1
            puts $2

        # Error: cannot be set:

            #$0 = "a"

    ##argv

            puts('ARGV = ' + ARGV.join(', '))

##env

    # Environment variables.

    # Print all environment:

        ENV.each do |k,v|
            #puts("ENV[#{k}] = #{v}")
        end

##io

        puts('stdout')
        print("stdout\n")

    ##stdout

        # The difference between `$stdout` and `STDOUT` is that `$stdout`
        # can be reassigned, so always use it for more flexibility.
        #
        # Only use `STDOUT` when doing things like `$stdout = STDOUT`
        # to return to the actual stdout.

        # Good:

            $stdout.puts('stdout')

        # Bad

            STDOUT.puts('stdout')

            $stdout = STDERR
            STDOUT.puts('stderr')

        # Error: `STDOUT` is a constant:

            #STDOUT = STDERR

        # `$stdout` is more flexible:

            $stdout = STDERR
            STDOUT.puts('stderr')
            $stdout = STDOUT

        # Of course, `$stderr` and `STDERR` also exist:

            STDERR.puts('stderr')
            $stderr.puts('stderr')

    # Puts format things in the same way as format strings.

        s = [1, 2]
        puts "#{s}"
        puts s

##process

    ##id of current process

            print "$$ = #{$$}"

    ##backticks

        # Short to write, but the most flexible method.

            n = 1
            o = `ruby -e 'print #{n}'`
            o == '1' or raise

    ##popen3

        # More general process IO.
