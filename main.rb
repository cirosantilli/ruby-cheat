#!/usr/bin/env ruby

require 'tempfile'

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

##variables

    not defined? not_yet_defined or raise
    a = 1
    defined? a or raise

  ##built-in variables

      puts("RUBY_VERSION = #{RUBY_VERSION}")
      puts("RUBY_PATCHLEVEL = #{RUBY_PATCHLEVEL}")
      puts("__FILE__ = #{__FILE__}")
      puts("__LINE__ = #{__LINE__}")

##object

  # Base class of all types.

  # Also note that it includes the Kernel module.

  ##inspect

    # Human readable string representation of an object.

      [0, 1].inspect == '[0, 1]' or raise
      "\n".inspect == "\"\\n\"" or raise

    # Difference between `to_s`: `inspect` is more precise representation
    # more adapted for debugging than end-user display.

    # Same as Python `repr` relative to `str`.

##kernel

  # Included by the Object class.

  # It contains therefore many *built-in* methods such as print, puts, Array, etc.

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

  ##compare strings

      s1 = 'a'
      s2 = 'a'
      s3 = 'b'

    # `==` and `eql?` are the same and compare by content

      s1 == s2 or raise
      s1 != s3 or raise
      s1.eql?(s2) or raise
      not s1.eql?(s3) or raise

    # `equal?` compares by instance:

      not s1.equal?(s2) or raise

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

    # Brackets not required for instance and class variables:

      class C
        @@i = 0
        def initialize()
          @i = 1
        end
        def method()
          "#@@i#@i"
        end
      end
      c = C.new
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

    s = <<-MINUS_MEANS_TERMINATOR_CAN_HAVE_SPACE
a
b
    MINUS_MEANS_TERMINATOR_CAN_HAVE_SPACE
    s == "a\nb\n" or raise

  ##gsub

    # Regex find and replace.

    # Numbered capture groups:

      "a0".gsub(/a(.)/, 'b\1') == "b0" or raise

    # Named capture groups:

      "a0".gsub(/a(?<name>.)/, 'b\k<name>') == "b0" or raise

    # Hash case by case replace:

      "abcd".gsub(/../, {'ab'=>'01', 'cd'=>'23'}) == "0123" or raise

    # Block match replace:

      "a0".gsub(/\d/) {|s| (s.to_i + 1).to_s } == "a1" or raise

  ##scan

    # Make an array of all regexp matches on the string.

      "a0-b1-c2".scan(/(\w)(\d)/) == [['a', '0'], ['b', '1'], ['c', '2']] or raise

##regexp

  # Like in Perl, regexps have literals in Ruby.

  # There eis not however a `s//` substitution function special syntax:
  # regular functions such as the string gsub method are used for that.

  # Also check regexp methods present on the string class such as
  # gsub, scan,

    /a./.class == Regexp or raise

  ##=~

    # Non full matches work:

      /a./ =~ "a0c" or raise

  ##!~

    # Negation of `=~`:

      /a/ !~ "b" or raise

##symbols

  # Similar to strings but:
  #
  # - single instance
  # - immutable
  # - fast comparison by pointer
  #
  # A common usage is as dict keys.
  #
  # <http://stackoverflow.com/questions/6337897/what-is-the-colon-operator-in-ruby>

  # Strings are different from symbols.

    "abc" != :abc or raise

  # Symbols are immutable, single instance and fast to compare, strings are not:

    (not "abc".equal?("abc")) or raise
    :abc.equal?(:abc) or raise

  # Literals can include invalid id chars by using the following syntax:

    (:'a$b').to_s == 'a$b' or raise

##list

  # See array.

##array

  # Contains any number of objects of any type.

    is = [0, 'a', 'abc']
    is[0] == 0 or raise
    is[1] == 'a' or raise

  # Also possible to create via explicit constructor:

    Array.new        == [] or raise
    Array.new(3)       == [nil, nil, nil] or raise
    Array.new(3, true) == [true, true, true] or raise

  # The following works because the `[]` operator overload can have any number of arguments:

    Array.[](1, 2) == [1, 2] or raise
    Array[1, 2]    == [1, 2] or raise

  # Special syntax for an array of strings literal:

    ss = %w{ ab cd ef }
    ss == ['ab', 'cd', 'ef'] or raise

  # Range array:

    (0..2).to_a() == [0, 1, 2] or raise
    Array(0..2)   == [0, 1, 2] or raise

  # Length:

    [0, 1, 2].length() == 3 or raise

  # Unpack:

    i, j = [0, 1]
    i == 0 or raise
    j == 1 or raise

  # Array to string:

    ['ab', 'cd'].join(' ') == 'ab cd' or raise

  # Slice: specifies the `[start, number of args]`:

    a = [0, 1, 2, 3]
    a[0, 2] == [0, 1] or raise
    a[0, 3] == [0, 1, 2] or raise
    a[1, 2] == [1, 2] or raise

  ##append inplace ##<<

      a = [1]
      a << 2 == [1, 2] or raise
      a == [1, 2] or raise

    # Returns reference to the array:

      a = [1]
      b = a << 2
      b[0] = -1
      b == [-1, 2] or raise

  ##concatenate

    # Create new array.

      a = [0, 1]
      a + [2, 3] == (0..3).to_a or raise
      a == [0, 1] or raise

  ##map method

    # Creates a new array of modified elements.

      a = (0..2).to_a
      a.map { |x| x + 1 } == (1..3).to_a or raise
      a == (0..2).to_a or raise

    # In place version. Returns the modified map itself.

      a = (0..2).to_a
      b = a.map! { |x| x + 1 }
      b == (1..3).to_a or raise
      a == (1..3).to_a or raise
      b[0] = 0
      a == [0, 2, 3] or raise

##range

  # Different from Array.

    r = 1..3

  # ERROR: no [] operator

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

  # It is possible to ommit the `{}` when inside a function call:

    def f(h)
      h[1]
    end

    f(1=>'one', 2=>'two') == 'one' or raise
    f 1=>'one', 2=>'two'  == 'one' or raise

  # A new syntax was added in 1.9 for hashes with symbol keys.
  # See what symbol is if you don't know yet.

    if RUBY_VERSION >= '1.9'
      m  = {:a=>1, :b=>2}
      m2 = {a: 1, b: 2}
      m == m2 or raise
    end

  ##hash foreach iteration

    # Iteration order: random in 1.8, same as literal in 1.9.

      m = {2=>'two', 1=>'one'}
      keys = [2, 1]
      i = 0
      m.each() do |k, v|
        if RUBY_VERSION >= '1.9'
          k == keys[i] or raise
        end
        m[k] == v or raise
        i += 1
      end

  # Non existing keys simply return nil value, no exception:

    x = {a: 1}
    x[:b] == nil or raise

  # It is possible to change the default via the explicit constructor:

    x = Hash.new(1)
    x[:a] == 1 or raise

  ##get ##fetch

    # Python get is called fetch: get val or given default if not present.

      h = {a: 1, b: 2}
      h.fetch(:a, 3) == 1 or raise
      h.fetch(:d, 3) == 3 or raise

##operators

  ##|| vs or

    # TODO

  ##||= ##or equals

    # Assign only if var is neither nil nor false.

    # Same as `x || x = y`.

      x = nil
      x ||= 1
      x == 1 or raise

      x = false
      x ||= 2
      x == 2 or raise

      x = 3
      x ||= 4
      x == 3 or raise

    # *Not* the same as `x = x || y`, because the assign only happens if var is neither nil nor false,
    # but an assign always happens for `x = x || y`.

    # Confusing, since this is different from the rest of the `+=` family, which always assigns.

      h = Hash.new(1)
      h[:a] ||= 2
      h.size == 0 or raise

  ##defined?

      not defined? not_yet_defined or raise
      not_yet_defined = 1
      defined? not_yet_defined or raise

##loops

  ##while

    # Statement:

      i = 0
      j = 0
      is = (0..2).to_a
      while i < 3 do
        is[j] == i or raise
        i += 1
        j += 1
      end
      j == 3 or raise

    # `do` is optional:

      i = 0
      j = 0
      is = Array(0..2)
      while i < 3
        is[j] == i or raise
        i += 1
        j += 1
      end
      j == 3 or raise


    # While modifier for single statement:

      i = 0
      i += 1 while i < 3
      i == 3 or raise

    # Single statement only:

      j = 0
      i = 0
      j += 1; i += 1 while i < 3
      i == 3 or raise
      j == 1 or raise

    # While modifier multiple statements:

      i = 0
      j = 0
      is = (0..2).to_a
      begin
        is[j] == i or raise
        i += 1
        j += 1
      end while i < 3
      j == 3 or raise

  ##until

    # Same as `while not <condition>`.

      i = 0
      j = 0
      is = (0..2).to_a
      until i == 3 do
        is[j] == i or raise
        i += 1
        j += 1
      end
      j == 3 or raise

  ##for in

      is = [0, 2]
      js = [1, 3]
      ijs = [[0,1],[2,3]]
      k = 0
      for i,j in ijs
        is[k] == i
        js[k] == j
        k += 1
      end
      k == ijs.length or raise

    # Do is optional

      is = [0, 2]
      j = 0
      for i in is do
        is[k] == i
        j += 1
      end
      j == is.length or raise

    ##each

      # each is an iterator function that loops over the elements of containers.

        $is = [0, 1, 2]
        $i = 0
        is.each() {
          $is[$i] == $i or raise
          $i += 1
        }
        j == 2 or raise

      # If no loop variables will be needed, the `||` can be omitted:

        i = 0
        (1..3).each() do
          i += 1
        end
        i == 3 or raise

    ##each_with_index

        a = []
        [0, 2, 1].each_with_index do |x, index|
          a << index
        end
        a == (0..2).to_a or raise

##range

  # This discusses ways to loop consecutive sequences of numbers,
  # not the Ruby class.

  ##each

      is = [1, 2, 3]
      j = 0
      (1..3).each() do |i|
        is[j] == i or raise
        j += 1
      end
      j == 3 or raise

  ##step

    # More general than each. Accepts any step.

      is = [1, 3, 5]
      j = 0
      (1..5).step(2) do |i|
        is[j] == i or raise
        j += 1
      end
      j == 3 or raise

  ##times

      is = [0, 1, 2]
      j = 0
      3.times() do |i|
        is[j] == i or raise
        j += 1
      end
      j == 3 or raise

##method ##function

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
      (f 1, 1) == 2 or raise

    # Special characters used for literals such as `"` for strings
    # don't need to be separated from the function name in a call:

      def f i
       return i
      end

      f"abc" == "abc" or raise
      f:abc == :abc or raise

    # TODO why does this give a syntax error:

      #f{a: 1} == {a: 1} or raise
      f({a: 1}) == {a: 1} or raise


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

    # `?` and `!` have no semantic value, and their meaning is
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

    # `=` gives the method a new possible shorthand setter syntax:

      o.int = 3
      o.int() == 3 or raise

    # Also works for compound operations:

      o.int += 1
      o.int() == 4 or raise

  ##variable length argument list #nargs

      def sum(i, *is)
        total = i
        is.each do |i|
          total += i
        end
        total
      end

      sum(1, 2, 3) == 6 or raise

  ##splat ##unpack argument list

    # Similar to python argument lists unpacking.

    # The asterisk ;ransforms an array into function argument list.

      def sum(i, *is)
        total = i
        is.each do |i|
          total += i
        end
        total
      end

      sum(*[1, 2, 3]) == 6 or raise

      def sum(i, *is)
        total = i
        is.each do |i|
          total += i
        end
        total
      end

  ##kwargs

    # Does not exist in ruby.

    # Similar syntax can be achieved however by passing a dictionary and omiting braces.

      def f(d)
      end

      f({a:1, b:2})
      f(a:1, b:2)

  ##global variable

      $i = 1
      i = 2
      $i == 1 or raise

      $i = 1
      def f()
        $i
      end
      f() == 1 or raise

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
      begin
        f()
      rescue NameError
      else
        raise
      end

  ##overload

    # Function overload does not exist.

    # Every new method with the same name as an existing one simply creates
    # a completely new method.

      def f() 1 end
      def f(i) 2 end

    # ERROR: f takes one argument:

      #f()

  ##lambda

    # Function without name.

    # Differences from Procs:
    #
    # - enforces correct number of arguments
    # - an explicit return statement does not stop caller (unlike Procs).

      f = lambda {|x| x + 1 }
      f.call(1) == 2 or raise

    if RUBY_VERSION >= '1.9'
      ##-> ##stabby lambda

        # Exact same as lambda, but new notation.

          f = ->(x) { x + 1 }
          f.call(1) == 2 or raise

        # Parenthesis is optional:

          f = -> x  { x + 1 }
          f.call(1) == 2 or raise

          f = ->x  { x + 1 }
          f.call(1) == 2 or raise
    end

##alias

  # Ruby keyword.

  # Creates a new name for an existing method.

    def f
      0
    end

  # Weird no comma syntax because it is a keyword:

    alias :g :f

    g == 0 or raise

##alias_method

  # Method of the `Module` class, so can only be used inside modules or classes (which inherit from modules).

  # Vs alias keyword: <http://stackoverflow.com/questions/4763121/should-i-use-alias-or-alias-method>

  # The main difference is that `alias_method` is a method and not a keyword,
  # so more standard things can be done to it.

    class AliasMethod
      def f
        0
      end

      alias_method :g, :f
    end

    AliasMethod.new.g == 0 or raise

##class

  # Everyting is an object, including integers and floats:

    1.class   == Fixnum or raise
    1.object_id
    1.1.class == Float  or raise
    nil.class == NilClass  or raise
    nil.object_id

  ##class attribute

    # It is possible to obtain the class of an object via the class attribute.

      class C
      end
      C.new.class == C or raise

  # Define a class:

    class C

      # The constructor.
      def initialize(i=1)
        @member_i = i
      end

      def method()

        # Call another method of the instance:

          method2() == 2 or raise
          self.method2() == 2 or raise

        # Access an instance variable:

          @member_i

        # ERROR: TODO why? It works for methods.

          #self.@member_i
      end

      def method2()
        2
      end

    end

  # In Ruby, Classes are also (constant) objects. `new` is just a method of that object:

    c = C.new(1)
    c.method() == 1 or raise

  # The constructor is private: TODO how to make other methods private?

    #c.initialize()

  # `new` automatically calls `initialize` with the same parameters it was given,
  # which is a special name for the constructor.

  # Errors:

    #c.not_a_member = 2
    #c.@not_a_member = 2

  # Any statement can on in a class.

    class C
      true or raise
    end

  ##get set methods

    # Error: it is not possible to access instance members directly:

      #c.member_i == 1 or raise
      #c.@member_i == 1 or raise

    # However, if there are getter and setter functions, it is possible to
    # emulate the syntax of public member access:

      class GetSet
        def initialize(i=1)
          @i = i
        end
        def i()
          return @i
        end
        def i=(i)
          @i = i
        end
      end

    # For the getter, it works because of parenthesis omission:

      o = GetSet.new

      o.i() == 1 or raise
      o.i   == 1 or raise

    # For the setter, the suffix `=` allows the following special syntax:

      o.i = 2
      o.i == 2 or raise

    # Which is the same as:

      o.i=(2)

    ##attr_reader ##attr_writer ##attr_accessor

      # Create getter, setter or both for member variables in a single line.

        class AttrAccess
          attr_reader :read
          attr_writer :write
          attr_accessor :both

          def initialize
            @read = 0
            @write = 1
            @both = 2
          end
        end

        a = AttrAccess.new

        a.read == 0 or raise
        begin
          a.read = -1
        rescue NoMethodError
        else
          raise
        end

        begin
          a.write
        rescue NoMethodError
        else
          raise
        end
        a.write = -1 or raise

        a.both = -1
        a.both == -1 or raise

  # It is possible to extend a class by adding new methods to an existing class
  # after its initial declaration.

    class AddMethod
      def m0()
        0
      end
    end

    class AddMethod
      def m1()
        1
      end
    end

    c = AddMethod.new
    c.m0() == 0 or raise
    c.m1() == 1 or raise

  # It is possible to add methods to specific instances of a class.
  # This is exactly what happens when creating static class methods.

    class AddMethodToInstance
    end

    c = AddMethodToInstance.new
    def c.m0
      0
    end
    c.m0 == 0 or raise

    d = AddMethodToInstance.new
    begin
      d.m0
    rescue NameError
    else
      raise
    end

  # Trying to do it outside defines a new class method:

    def C.method4()
      return 4
    end

    C.method4() == 4 or raise # ERROR

  ##self

      class Self
        # Inside the class scope, self is the class.
        #
        self == Self or raise

        # Inside instance methods, self is the instance.
        #
        def f
          self.class == Self or raise
        end
      end
      Self.new.f

  ##class methods and variables ##static

      class ClassMethod

        @class_i   = 1
        @@class_i2 = 2

        def private_klass_method
          0
        end

        begin
          private_klass_method
        rescue NameError
        else
          raise
        end

        def self.class_method
          @class_i   == 1 or raise
          @@class_i2 == 2 or raise
          class_method2 == 2 or raise

          begin
            private_klass_method
          rescue NameError
          else
            raise
          end

          1
        end

        # Better with self, to avoid repetition.
        #
        def ClassMethod.class_method2
          return 2
        end

        # Exact same as `ClassMethod`, but less repetition.
        #
        def self.class_method2
          2
        end

        # Exact same as `self.`, but even less repetition for multiple methods.
        #
        class << self
          def class_method3
            3
          end
        end

        def initialize()
          ClassMethod.class_method()
          #class_method()             #=> ERROR
          #@class_i   == 1 or raise #=> ERROR: @class_i is the instance member
          @@class_i2 == 2 or raise
        end
      end

      #ClassMethod.class_i2        == 2 or raise     #=> ERROR
      #ClassMethod.@@class_i2      == 2 or raise     #=> ERROR
      #ClassMethod.class_i         == 2 or raise     #=> ERROR
      #ClassMethod.@class_i        == 2 or raise     #=> ERROR
      ClassMethod.class_method   == 1 or raise
      ClassMethod.class_method2  == 2 or raise
      ClassMethod.class_method3  == 3 or raise

      c = ClassMethod.new
      #c.class_method() == 1 or raise           #=> ERROR
      #c.class_i2 == 1 or raise                 #=> ERROR

  ##operator overload:

      class OperatorOverload

        def +(i)
          return :sum
        end

        def [](i)
          return :square_bra
        end

      end

      o = OperatorOverload.new

    # Sugared versions exist because they are operators:

      o + o   == :sum         or raise
      o[1]    == :square_bra  or raise

    # But un-sugared versions also exist for all operator overloads:

      o.+(o)  == :sum
      o.[](o) == :quare_bra

    # The number or arguments for operator overloads if not fixed:

      class OperatorOverloadNargs

        def +(i, j, k)
          return :sum
        end

        def [](*args)
          return :square_bra
        end

      end

      o = OperatorOverloadNargs.new

      o.+(1, 2, 3)  == :sum or raise
      o.[](1, 2, 3) == :square_bra or raise

    # Square brackets also has a sugared version for multiple arguments:

      o[1, 2, 3] == :square_bra or raise

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

      d = Derived.new

    ##multiple inheritance

      # Multiple inheritance does not exist in Ruby.

      # However, Ruby has the concept of Module inclusion, which can provide very similar
      # behaviour to that of mulitle inheritance.

    ##super

      # Call constructor of base class.

        class Base
          def initialize(i)
            @i = i
          end
          def i()
            return @i
          end
        end

        class Derived < Base
          def initialize(i)
            super(i)
          end
        end

        Derived.new(1).i == 1 or raise

      # Without it, the base class constructor is not called at all.

        class DerivedNoSuper < Base
          def initialize(i)
          end
        end

        DerivedNoSuper.new(1).i == nil or raise

      # Common argument forwarding patterns:

        class DerivedForwardingBase
          attr_accessor :base, :opts, :args
          def initialize(base, opts, *args)
            @base = base
            @args = args
            @opts = opts
          end
        end

        class DerivedForwarding < DerivedForwardingBase
          attr_accessor :derived_only, :derived_only_opt
          def initialize(base, derived_only, opts, *args)
            @derived_only = derived_only
            @derived_only_opt = opts.delete(:derived_only_opt)
            # Use derived arguments here.
            super(base, opts, *args)
          end
        end

        o = DerivedForwarding.new(0, 1, {base:2, derived_only_opt:3}, 4, 5)
        o.base == 0 or raise
        o.derived_only == 1 or raise
        o.opts == {base:2} or raise
        o.derived_only_opt == 3 or raise
        o.args == [4, 5] or raise

    ##superclass

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

        Derived.superclass == Base or raise

      # All classes derive from `Object`:

        Base.superclass == Object or raise

  ##reflection

      class ReflectionBase
        def m_base
        end
      end

      class ReflectionDerived < ReflectionBase
        def ReflectionDerived.c
        end

        def m
        end
      end

    # class:

      ReflectionDerived.new.class == ReflectionDerived
      ReflectionDerived.class == Class

      #puts ReflectionDerived.methods.sort

    # All methods, including direved:

      #puts ReflectionDerived.instance_methods

    ##respond_to

      # TODO

        ReflectionDerived.new.respond_to?(:m) or raise

    # Exclude inherited methods:

      puts "instance_methods = "
      puts ReflectionDerived.instance_methods(false).sort

    ##send

      # Inherited from object.

      # Call method by symbol.

        class Send
          def add(a, b)
            a + b
          end
        end

        Send.new.send(:add, 1, 2) == 3 or raise

  ##<< for classes

    # <http://stackoverflow.com/questions/2505067/class-self-idiom-in-ruby>

    # Allows to specialize methods for a specific object of a class.

      a = '1'
      class << a
        def to_i
          2
        end
      end
      a.to_i == 2 or raise

      # New object: no more specialization.
      a = '1'
      a.to_i == 1 or raise

    # Common application: define static methods.

      class Static
        class << self
          def static
            0
          end
        end
      end
      Static.static == 0 or raise

##module

  # Modules are namespaces.

  # Modules are similar to classes execpt that:

  # - it is not possible to instantiate them
  # - it is possible to get a multiple inheritance effect by including many modules

    module M

      i = 1
      I = 2
      # Error:
      #M.i = 3
      #M.I = 3

      def M.f()
        # Error:
        #I
        M::I
        self::I
        1
      end

      def self.f1()
        1
      end

      class << self
        def f1_2()
          1
        end
      end

      def f2()
        2
      end

      class C
        def f()
          1
        end
      end

    end

    M.f() == 1 or raise
    M::f() == 1 or raise

    M.f1() == 1 or raise
    M.f1_2() == 1 or raise

  # Inner methods are invisible:

    #M::f2() == 2 or raise
    #f2() == 2 or raise

  # Dot `.` and double colon `:` are the same except for constants,
  # in which case only the colon works:

    #M.i == 1 or raise
    #M.I == 1 or raise
    #M::i == 2 or raise
    M::I == 2 or raise
    # Warning: modifying already initialized constant.
    #M::I = 3

  # Classes are constant objects so:

    #M.C.new.f() == 1 or raise
    M::C.new.f() == 1 or raise

  # Error: cannot add variables to the module after its creation:

    #M.j = 1

  # Can add new functions to the module after its creation:

    module Extend
      def self.f0()
        0
      end
    end

    module Extend
      def self.f1()
        1
      end
    end

    def Extend::f2()
      2
    end

    class Extend::C
      def self.f0
        0
      end
    end

    Extend.f0() == 0 or raise
    Extend.f1() == 1 or raise
    Extend.f2() == 2 or raise
    Extend::C.f0() == 0 or raise

  ##include

    # Make module functions into instance methods.

      module IncludeModule

        def f2()
          2
        end

        def IncludeModule.f3()
          2
        end

      end

      class IncludeClass
        include IncludeModule
        def f1()
          1
        end
      end

      IncludeClass.new.f1() == 1 or raise
      IncludeClass.new.f2() == 2 or raise
      # Error: undefined
      #IncludeClass.new.f3()

  ##extend

    # Make module functions into class methods.

      class ExtendClass
        extend IncludeModule
      end

      ExtendClass.f2() == 2 or raise

    # ERROR: undefined

      #ExtendClass.f3()

##closure

  # Ruby has 4 closure types:

  # - blocks
  # - Procs
  # - lambdas
  # - Methods

##block ##yield ##iterator ##do

  # Implement closures: functions + data.

  # yield calls the bock that has been passed to the function:

    def f()
      # This calls the block:
      yield() == 2 or raise
      yield() == 2 or raise
    end

    i = 0
    f() { # This is the block.
      i += 1

      # ERROR: cannot use return here.
      #return 2

      # This value will be returned.
      2
    }
    i == 2 or raise

  # Do version:

    i = 0
    f() do
      i += 1
      #return 2 # ERROR
      2
    end
    i == 2 or raise

  # There seems to not be any semantical difference between the two of them,
  # except precedence and different usage convention: <http://stackoverflow.com/questions/2122380/using-do-block-vs-brackets>

  # Note how the local variable `i` is modified  inside `f` by `yield`.
  # This is because the block is not just a function: it is a *closure*,
  # so it also "contains" variables. This could not be achieved by passing
  # a simple function as argument:

    def f(func)
      func() == 2 or raise
    end

    i = 1
    def g()
      # Cannot change the outter i from here!
      # This will create a local i.
      i += 1
      2
    end
    i == 1 or raise

  # Blok arguments:

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

  ##block context

      @class_i   = -1
      @@class_i2 = -2

      class C

        @class_i   = 1
        @@class_i2 = 2

        def C.class_method_yield()
          yield()
        end

        def C.class_method()
          return 1
        end

        def self.self_method_yield()
          yield()
        end

        def self.self_method()
          return 1
        end

        def initialize()
          @i = 0
        end

        def method_yield()
          yield()
        end

        def method()
          return 1
        end
      end

      o = C.new
      o.method_yield() do
        #method()           #=> undefined
        @class_i   == -1 or raise
        @@class_i2 ==  2 or raise
        #class_method()     #=> undefined
        #self_method()      #=> undefined
      end

      C.class_method_yield() do
        @class_i   == -1 or raise
        @@class_i2 ==  2 or raise
        #class_method()     #=> undefined
        #self_method()      #=> undefined
      end

      C.self_method_yield() do
        @class_i   == -1 or raise
        @@class_i2 ==  2 or raise
        #class_method()     #=> undefined
        #self_method()      #=> undefined
      end

  ##optional block

    # If `yield` is used in a function, it is mandatory to pass a block to the function,
    # or this yields a runtime error.

      def f()
        yield()
      end

    # Doing:

      #f()

    # Would give:

      #`f': no block given (yield) (LocalJumpError)

    # But the following is fine:

      def f()
        true or yield()
      end

      f()

    # It is possible to detect if a block was passed or not:

      def f()
        if block_given?()
          return yield()
        else
          return 0
        end
      end

      f()       == 0 or raise
      f() { 1 } == 1 or raise

  ##ampersand syntax

      def f(&code)
        code.call() == 2 or raise
      end

      i = 0
      f() do
        i += 1
        2
      end
      i == 1 or raise

      i = 0
      f() {
        i += 1
        2
      }
      i == 1 or raise

    # With arguments:

      def f(i, j, &code)
        i == 1
        code.call() == 2 or raise
        j == 3
      end
      i = 0
      f(1, 3) do
        2
      end

    # The ampersand can only be the last function argument.
    # This excludes functions with multiple ampersand parameters.

    # `i` is the last:

      #def f(&code, i) end

    # `code2` is the last. `code` is not:

      #def f(&code, &code2) end

    ##ampersand block

        class AmpersandBlock
          attr_accessor :i
          def initialize(i)
            @i = i
          end
        end

        a = [0, 1, 2]
        a2 = a.map { |x| AmpersandBlock.new(x) }
        a2.map(&:i) == a or raise

##proc

  # Short for procedure. Has corresponding class `Proc`.

  # Same as blocks, but passed explicitly as function arguments.

  # Explicit proc creation:

    def f(code)
      code.call() == 2 or raise
    end

    p = Proc.new do
      i += 1
      2
    end
    i = 0
    f(p)
    i == 1 or raise

  # Temporary Proc:

    i = 0
    f(Proc.new do
      i += 1
      2
    end)
    i == 1 or raise

  # Pass multiple procs:

    def f(code, code2)
      code.call() == 2 or raise
      code2.call() == 2 or raise
    end

    p = Proc.new do
      i += 1
      2
    end

    i = 0
    f(p, p)
    i == 2 or raise

  ##return statement inside procs

    #http://stackoverflow.com/questions/17800629/unexpected-return-localjumperror

    g = Proc.new do
      return 1
    end

    def f(g)
      g.call()
      2
    end

    #TODO
    #f(g) == 2 or raise

  ##proc vs block

    # Every block is a proc:

      def f(&code)
        code.class() == Proc or raise
      end

    # Procs are more versitile:

    # - reuse a block of code multiple times.
    # - method will have one or more callbacks.

    # The downside of Proc is that it is more verbose.

##dsl #metaprogramming

  # Domain Specific Language

  # Ruby features allow APIs to furnish interfaces that *look* like new languages,
  # but are just plain Ruby.

  # This is why people talk about *metaprogramming*, which makes sense if you consider
  # that you really are creating a new language via your Ruby interface.

  # They are not however real new languages, just very sugared Ruby APIs.

  # One impotant example is a Rakefile

    #task a: :b do
      #sh "echo a"
    #end

  # It looks like a new language because:
  # - the `sh` method is only efined insded the `do` block,
  # - it was not required on global scope and
  # - it is not clear that it is class method:

  # The main lanauge feature used to implement such Ruby DSL is `instance_eval`,
  # or `class_eval`

##instance_eval ##class_eval

  # Useful for DSL like interfaces.

  # instance_eval: Evaluates inside the same scope as instances of the class.

    class InstanceEval
      def initialize
        @i = 1
      end

      def takes_proc(&proc)
        instance_eval(&proc)
      end

      def self.f
        0
      end
    end

  # The instance here is the object of the class:

    InstanceEval.new.instance_eval { @i } == 1 or raise
    InstanceEval.new.takes_proc    { @i } == 1 or raise

  # The instance here is the class:

    InstanceEval.instance_eval do
      def self.g
        f
      end
    end

    InstanceEval.g == 0 or raise

  # class_eval: evaluates inside the given instance, i.e., the class object.

    class ClassEval
      def initialize
        @i = 1
      end
    end

    ClassEval.class_eval do
      def f
        @i
      end
    end

    ClassEval.new.f == 1 or raise

##instance_exec ##class_exec

##require and friends

  ##require

    # ERROR: require does not look under current dir starting from 1.9.2.
    # Use `require_relative` for that.

      #require 'main2'

    # Require search path:

      puts('require search path:')
      puts($:)
      ($LOAD_PATH)

  ##require_relative

      require_relative('main2')

    # Non-const variables are bad. Everything else is ok.

      begin
        main2_i
      rescue NameError
      else
        raise
      end

      Main2_const == 2 or raise

      main2_f() == 2 or raise
      Main2.f() == 2 or raise
      AnyName.f() == 2 or raise

    # Requires of requires are also required:

      main3_f() == 3 or raise

  ##autoload

    # Lazy module loading for constants.

    # The constant is only loaded when first used.

    # Does not have a relative version.

      #autoload_relative :AutoloadConst, 'autoload_test'

      #AutoloadConst == 1 or raise

    # AutoloadConst2 was not loaded:

      #begin
        #autoload :autoload_non_const, 'autoload_test'
      #rescue NameError
      #else
        #raise
      #end

    # Only constants can be autoloaded.

      #begin
        #autoload :autoload_non_const, 'autoload_test'
      #rescue NameError
      #else
        #raise
      #end

##exception ##raise ##rescue

    begin
      raise(NameError)
    rescue NameError
    else
      raise
    end

  # Empty rescue rescues all:

    begin
      raise(TypeError)
    rescue NameError
      raise
    rescue
    end

  # Only exception classes can be raised or `TypeError`:

    begin
      begin
        raise(1)
      rescue TypeError
      else
        raise
      end
    end

##throw ##catch

  #Vs raise rescue: <http://stackoverflow.com/questions/51021/what-is-the-difference-between-raising-exceptions-vs-throwing-exceptions-in-ruby>

##math

    Math.sqrt(9) == 3 or raise

##command line arguments

  ##global variables ##$

      puts($0)
      puts($1)
      puts($2)

    # Error: cannot be set:

      #$0 = "a"

  ##argv

      puts('ARGV = ' + ARGV.join(', '))

##env

  # Environment variables.

  # Print all environment:

    ENV.each() do |k,v|
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
    puts("puts format:")
    puts("#{s}")
    puts(s)

##File

  # File and pathname operations.

  # Generate a temporaty file path for tests:

    file = Tempfile.new('abc')
    path = file.path
    file.unlink

  ##path operations

    ##join

        File.join("a", "b", "c") == "a" + File::SEPARATOR + "b" + File::SEPARATOR + "c" or raise

    ##basename

        File.basename(File.join("a", "b", "c")) == "c" or raise

    ##exists

      # Do not confound with `exist?` which is only for directories!

        not File.exists?(path) or raise
        file = File.new(path, 'w')
        file.close
        File.exists?(path) or raise
        File.unlink(path)
        not File.exists?(path) or raise

  ##open ##write ##read ##write

    # Must use `'b'` if there will be non ascii chars.

      data = 'abc'

      File.open(path, 'w') do |f|
        f.write(data)
      end
      File.read(path) == data or raise

    ##linewise

        data_read = ""
        file = File.new(path, "r")
        while line = file.gets
            data_read += line
        end
        file.close
        data_read == data or raise

      File.unlink(path)

##Dir

  ##list directory ##ls

      Dir.entries(".")

  ##rmdir

    # Remove empty directory. For non empty, consider `fileutils.rm_rf`.

      #Dir.rmdir(".")

##fileutils

  ##rm_rf

      require 'fileutils'
      #FileUtils.rm_rf(dir)

##Tempfile

    require 'tempfile'
    file = Tempfile.new('abc')
    puts "Tempfile.new('abc').path = " + file.path      # => A unique filename in the OS's temp directory,
                  #    e.g.: "/tmp/foo.24722.0"
                  #    This filename contains 'foo' in its basename.
    file.write("hello world")
    file.rewind
    file.read      # => "hello world"
    file.close
    file.unlink    # deletes the temp file

##process

  ##id of current process

      puts "$$ = #{$$}"

  ##backticks

    # Short to write, but the most flexible method.

      n = 1
      o = `ruby -e 'print #{n}'`
      o == '1' or raise

    # Sets the `$?` variable.

      # puts $?.exitstatus

  ##popen3

    # More general process IO.

  ##current user ##uid

      puts "Process.euid = " + Process.euid.to_s

##time date

  # Current time as ISO string (from year to second):

    puts "Time.now = " + Time.now.to_s
