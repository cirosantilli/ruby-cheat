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

##built-in variables

    puts "RUBY_VERSION = #{RUBY_VERSION}"
    puts "RUBY_PATCHLEVEL = #{RUBY_PATCHLEVEL}"
    puts "__FILE__ = #{__FILE__}"
    puts "__LINE__ = #{__LINE__}"

##string

    # Concatenate:

        "a" + "b" == "ab" or raise

    ##format

        s = "bc"
        "a#{s}d" == "abcd" or raise

        # Escape:
        s = "a"
        "\#{s}" == "#" + "{s}" or raise

        # Brackets required:
        s = "a"
        "#s" == "\#s" or raise

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

    ##EOF

        s = <<EOF
a
b
EOF

    s == "a\nb\n" or raise

##list

    # See array.

##array

    # Contains any number of objects of any type.

    is = [0, 'a', "abc"]
    is[0] == 0 or raise
    is[1] == 'a' or raise

    # Also possible to create via explicit constructor:

    Array.new == [] or raise
    Array.new(3) == [nil, nil, nil] or raise
    Array.new(3, true) == [true, true, true] or raise

##range

    # Different from Array.

    r = (1..3)

    # Error: no [] operator
    #r[1] == 2

    # Convert to array:
    (1..3).to_a == [1, 2, 3] or raise

    # Triple dot excludes end:
    (1...3).to_a == [1, 2] or raise

    # Possible on chars and strings:
    ('a'..'c').to_a == ['a', 'b', 'c'] or raise
    ("aa".."ac").to_a == ["aa", "ab", "ac"] or raise

    # Range test:
    (1..3) === 2 or raise
    (1..3) != 2 or raise

    # Not reflexive:
    not 2 === (1..3) or raise

##map

    # See hash.

##hash

    m = {1=>"one", 2=>"two"}
    m[1] == "one" or raise
    m[2] == "two" or raise

    ##hash foreach iteration

        # Iteration order: random in 1.8, same as literal in 1.9.

        m = {2=>"two", 1=>"one"}
        keys = [2, 1]
        i = 0
        m.each do |k, v|
            if RUBY_VERSION >= "1.9"
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

##function

    ##return value

        # Like in Perl, is the value of the last statement.

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

##loops

    ##for in loop

        #is = (1..3)
        #j = 0
        #(1..3).each do |i|
            #is[j] == i or raise
            #j += 1
        #end

##class

    class C

        @@class_i

        def initialize(i)
            @member_i = i
        end

        def method()
            @member_i
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

##module

    # Modules are namespaces.

    module M
        i = 1
    end
    M.i == 1 or raise

##math

    Math.sqrt(9)

##io

    puts "stdout"
    print "stdout\n"
