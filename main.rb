#!/usr/bin/env ruby

require 'tempfile'

##Comments

  # Multiline comments:

=begin a
  multi
  line comment
=end

  # `=` Must be the first thing on the line. The following would be a syntax error:

    #=begin
    #=end

##Spaces ##Newline ##Semicolon

  # Indentation is not mandatory:

    true
      true
  true

  # Newlines dispense semicolon `;` to delimitates statements.

    1 + 1
    1 + 1

  # Semicolon `;` needed for multiple statements on a single line.

    1 + 1; 1 + 1

  # If some operators like `+` are encountered at the end of line,
  # then the line continues automatically:

    1 +
    1 == 2 or raise

  # To force line continuation, use a backslash.
  # In practice, the only use case for this is spliting up long strings
  # not to blow up line width limits:

    'a' \
    'b' == 'ab' or raise

  # This is the only use case recommende by bbatsov style.

  # Spaces may disambiguate certain statements. See function.

##Identifiers

  # Most of the rules are like for C: `a-zA-Z0-9_`, not start in `0-9`, canse sensitive.

  # But:

  # -   method names can end in `?`, `!` or `=`. This has no syntatical value,
  #     but each has a very well defined and followed convention.

  # -   variable names that start with an Upper case letter called constants
  #     and behave specially in many ways.

  # - class names must start with an upper case character, or an error is generated.

    # Error:

      #class c end

##Variables

    not defined? not_yet_defined or raise
    a = 1
    defined? a or raise

  # As a super dynamic language, variables are defined by `=`.

  # Left side is defined first.

    def f
      (a = a) == nil or raise
    end
    f

  ##Built-in variables

    # TODO Where are they documented??

    ##FILE

      # Relative path to file being run:

        puts("##__FILE__ = #{__FILE__}")

      # Sample outputs:

        #./main.rb
        #./ruby-cheat/main.rb

    ##LINE

      # Current line in the file:

        puts("##__LINE__ = #{__LINE__}")

    ##RUBY_VERSION

        puts("##RUBY_VERSION = #{RUBY_VERSION}")

      # Can be used to run version specific code. For current versions,
      # works naively as:

        if RUBY_VERSION >= '1.9'
          puts("RUBY_VERSION >= 1.9")
        end

      # But this will someday break because of the string compare.
      # To do it robustly use `Gem::Version`:

        if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('1.9')
          puts("RUBY_VERSION >= 1.9")
        end

    ##RUBY_PATCHLEVEL

      # E.g., Ruby `2.1.1p76` has patchlevel `76`.

        puts("##RUBY_PATCHLEVEL = #{RUBY_PATCHLEVEL}")

    ##RUBY_PLATFORM

        puts("##RUBY_PLATFORM = #{RUBY_PLATFORM}")

      # Sample output:

        #x86_64-linux

    ##RUBY_RELEASE_DATE

        puts("##RUBY_RELEASE_DATE = #{RUBY_RELEASE_DATE}")

      # Sample output:

  ##if __name__ == '__main__'

    # Design pattern to run something only when executed, not when required:

      if __FILE__ == $0
        puts('__FILE__ == $0')
      end

##Constants

  # Like regular variables, but start with upper case letter

  # Constants are... somewaht constants:

  # OK: definition:

    Ii = 0

  # Warning: modifying constant:

    #Ii = 1

  ##Constant lookup

    # - Each entry in `Module.nesting1
    # - Each entry in `Module.nesting.first.ancestors`
    # - Each entry in `Object.ancestors` if `Module.nesting.first` is `nil` or a module.

    # Tutorial: http://cirw.in/blog/constant-lookup.html

##Object

  # Base class of almost all types.

  # Includes the Kernel module, and inherits from `BaseObject`.

  # The global scope executes inside Object:

    self.class == Object or raise

  # This is why Kernel methods are always included.

  ##inspect

    # Human readable string representation of an object.

      [0, 1].inspect == '[0, 1]' or raise
      "\n".inspect == "\"\\n\"" or raise

    # Difference between `to_s`: `inspect` is more precise representation
    # more adapted for debugging than end-user display.

    # Same as Python `repr` relative to `str`.

  ##tap

    # Create a block, pass tapped object to it, and return the object in the end.

    # Major applications: making your app harder to read:
    # http://stackoverflow.com/questions/17493080/advantage-of-tap-method-in-ruby

      1.tap { |x| 2 } == 1 or raise

##BaseObject

  # Base class of all classes.

  ##method_missing

    # What to do is a method is not found.

    # By default raises an exception, but can do anyhting.

    # Don't ever use this: it is really hard to find out
    # where methods are being defined, hard to document, etc.

      class MethodMissing
        def method_missing(sym)
          sym
        end
      end

      MethodMissing.new.asdf == :asdf or raise

  ##const_missing

    # `method_missing` for constants.

    # Used by rails for on the fly constant lookup.

      class ConstMissing
        def self.const_missing(sym)
          $sym = sym
        end
      end
      ConstMissing::Asdf == :Asdf or raise

##Kernel

  # Included by the Object class.

  # It contains therefore many "built-in" methods such as print, puts, Array, etc.

##nil

  # http://www.ruby-doc.org/core-2.1.3/NilClass.html

    nil.class == NilClass or raise

  # Does have some convertion metods to the triviel element of other classes:

    nil.to_i == 0 or raise
    nil.to_s == '' or raise

  ##nil?

    nil.nil?       or raise
    not false.nil? or raise

##Integer

  # http://www.ruby-doc.org/core-2.1.3/Integer.html

  ##Underscores in integer literals

    # Underscore in integer literals are ignored.
    # Use them for readability for long integers.

      1_000_000 == 1000000 or raise
      1_0_00_0_00 == 1000000 or raise

    # Cannot start, end or have multiple consecutive underlines:

      #_1
      #1_
      #1__0

  # Immutable.

##String

  ##Strings are mutable

    # Unlike Python, Ruby strings are mutable. Implicaiton: slow to compare for equality.

    # Ruby has symbols which are immutable instead.

      s = 'a'
      s[0] = 'b'
      s == 'b' or raise

  ##Literals

    ##Quoting

      # Single or double quotes can be used with the difference that with single quotes:

      # - backslash escapes are not interpreted except for `\\` and `\'`
      # - format strings are not interpreted

        '\\' == "\\" or raise
        '\'' == "'"  or raise

      ##arbitrary delimier ##percent string literls ##%Q

        # The percent allows to use many delimiter characters:

          'a' == %<a> or raise
          'a' == %!a! or raise

        # If the delimier is a character with a closing correspondent,
        # use the closing correspondent to close.

        # Delimiter must be an special char:

          #'a' == %bab or raise

        # `Q` is the default and thus optional modifier, which behaves like double quotes (interpolated):

        # `q` is for non-interpolated.

          "\n" == %Q{\n} or raise
          "\n" == %{\n}  or raise
          '\n' == %q{\n} or raise

    ##Multiline string literals

      ##With newlines

        ##Quotes or percent

            s = 'a
 b'
            s == "a\n b" or raise

            s = %{a
 b}
            s == "a\n b" or raise

        ##Heredoc

          # Advantage over quotes: allows you to set a custom terminator
          # in case the content has quotes

            s = <<EOF
 a
  b
EOF
            s == " a\n  b\n" or raise

            s = <<ANY_STRING_OK
a
ANY_STRING_OK
            s == "a\n" or raise

            s = <<-MINUS_MEANS_TERMINATOR_CAN_HAVE_SPACE_BEFORE
a
b
            MINUS_MEANS_TERMINATOR_CAN_HAVE_SPACE_BEFORE
            s == "a\nb\n" or raise

          # The EOF can be anywhere in the line, not necessarily at the end:

            s = <<EOF == "a\nb\n" or raise
a
b
EOF

          # Very ugly, but allows you to place the string literal anywhere.
          # E.g.: heredoc string inside array:

            a = [<<EOF]
a
EOF
            a == ["a\n"] or raise

  ##Compare strings

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

  ##Concatenate

    # Create new:

      a = 'ab'
      'ab' + 'cd' == 'abcd' or raise
      a == 'ab' or raise

    # In place after:

      a = 'ab'
      b = a << 'cd'
      b[0] = '0'
      a == '0bcd' or raise

    # Same but more verbose with `concat`.
    # Note that the two methods are different for Array.

      a = 'ab'
      b = a.concat('cd')
      b[0] = '0'
      a == '0bcd' or raise

    # In-place before:

      a = 'ab'
      b = a.prepend('cd')
      b[0] = '0'
      a == '0dab' or raise

    # Same, less clean and more general with `insert(0`:

      a = 'ab'
      b = a.insert(0, 'cd')
      b[0] = '0'
      a == '0dab' or raise

  ##Format

      s = 'bc'
      "a#{s}d" == 'abcd' or raise

    # Only works for double quoted strings:

      s = 'a'
      '#{s}' == '#' + '{s}' or raise

    # Arbitrary delimier:

      s = 'a'
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
        def initialize
          @i = 1
        end
        def method
          "#@@i#@i"
        end
      end
      c = C.new
      c.method == "01" or raise

    # Anything can be formatted (TODO what does it have to implement?)

      "#{1}"          == '1' or raise
      "#{[1, 2, 3]}"  == '[1, 2, 3]' or raise
      "#{1..3}"       == '1..3' or raise
      h = {1=>'one', 2=>'two'}
      "#{h}"          == '{1=>"one", 2=>"two"}' or raise

  ##match

    # Regexp match:

      'a0'.match(/a./) or raise

    # Convert strings into regexps:

      'a0'.match('a.') or raise

  ##Check if contains substring

      'abcd'.include?('bc') or raise
      !'abcd'.include?('bd') or raise

  ##=~

    # Regexp match. Returns:

    # - position of match if any
    # - nil otherwise

      ('a0'  =~ /a./) == 0   or raise
      ('ba0' =~ /a./) == 1   or raise
      ('b0'  =~ /a./) == nil or raise

    # Since `0` is truthy in Ruby, it is fine to write:

      'a0'  =~ /a./ or raise

    # Unlike `match`, does not convert strings into regexps:

      begin
        'a0' =~ 'a.'
      rescue TypeError
      else
        raise
      end

  ##!~

    # Returns:
    #
    # - true if not match
    # - false if match

  ##gsub

    # Regex find and replace multiple non overlapping times:

      'aa'.gsub(/./, 'b') == 'bb' or raise

    # Numbered capture groups:

      'a0'.gsub(/a(.)/, 'b\1') == 'b0' or raise

    # Named capture groups:

      'a0'.gsub(/a(?<name>.)/, 'b\k<name>') == 'b0' or raise

    # Hash: case by case replace:

      'abcd'.gsub(/../, {'ab'=>'01', 'cd'=>'23'}) == '0123' or raise

    # Block match replace:

      'a0'.gsub(/\d/) {|s| (s.to_i + 1).to_s } == 'a1' or raise

  ##scan

    # Make an array of all regexp matches on the string.

      'a0-b1-c2'.scan(/(\w)(\d)/) == [['a', '0'], ['b', '1'], ['c', '2']] or raise

  ##start_with?

      'abc'.start_with?('ab') or raise

  ##encoding

##regexp

  ##literal

    # Like in Perl, regexps have literals in Ruby.

    # There eis not however a `s//` substitution function special syntax:
    # regular functions such as the string gsub method are used for that.

    # Also check regexp methods present on the string class such as # gsub, scan,

    # There are two equivalent syntaxes for regexp literals:

      /a./.class == Regexp or raise
      %r{a.}.class == Regexp or raise

    # // syntax is cleaner ans shorter, better unless you have lots of slashes like in HTML.

    # The only difference is what you have to backslash escape on each:

      /\/}/   =~ '/}' or raise
      %r{/\}} =~ '/}' or raise

    # Regexp literals accept substitution just like double quoted strings:

      s = '.c'
      /a#{s}/ =~ 'a0c' or raise

    # Character classes:

      # -   `^` and `$` start / end of string or after / before newline
      #
      # -   `\A`, `\Z` and `\z`: like `^` and `$` but not around newlines
      #
      #     Use them instead for input validation as they are more strict:
      #     `me@example.com\n<script>dangerous_stuff;</script>`
      #
      #     `\z` matche includes the newline, `\Z` excludes it.

  ##=~

    # Non full matches work:

      /a./ =~ 'a0c' or raise
      /a/  =~ 'a' or raise

    # Also exists for the String class

  ##!~

    # Negation of `=~`:

      /a/ !~ 'b' or raise

  ##$1 ##$2 ##capture groups

    # Unintuitivelly, $1, ... are not argv (since $0 is the program name), but capturing groups of the last regex.

    # Keep the last regexp matching group.

      /a(.)/ =~ 'a0'
      $1 == '0' or raise

    # Error: can't set variable.

      #$1 = 1

  ##$~

    # MatchData from previous successful match.

  ##$&

    # Matched string from the previous successful pattern match:

    'abcd'.match(/b.d/)
    $& == 'bcd'

  ##$+

    # Last match groups from the previous successful pattern match.

      'abcd'.match(/(b)(.)(d)/)
      $+ == ['abcd', 'b', 'c', 'd']

  ##$` ##$'

    # String before / after the actual matched string of the previous successful pattern match.

      'abcd'.match(/b./)
      $` == 'a' or raise
      $' == 'd' or raise

##Symbols

  # Similar to strings but immutable.
  #
  # Therefore faster to compare for equality.
  #
  # A common usage is as dict keys.
  #
  # <http://stackoverflow.com/questions/6337897/what-is-the-colon-operator-in-ruby>

  # Strings are different from symbols.

    'abc' != :abc or raise

  # Symbols are immutable, single instance and fast to compare, strings are not:

    (not 'abc'.equal?('abc')) or raise
    :abc.equal?(:abc) or raise

  # Literals can include invalid id chars by using the following syntax:

    (:'a$b').to_s == 'a$b' or raise

  # Symbols can also end in `=`, `?` or `!` without quotes like methods:

    (:a?).to_s == 'a?' or raise
    (:a!).to_s == 'a!' or raise
    (:a=).to_s == 'a=' or raise

  # This is useful together with the `send` method.

##list

  # See array.

##Enumerable

  # Module.

  # The most prototypical includer ir Array.

  # Its cheat is currently not separated from that of Array TODO.

##Array

  ##Elements are references

    # Like in Python, doing `=` always passes references.

      l0 = [0]
      l1 = l0
      l1[0] = 1
      l0 == [1] or raise

      l0 = [0]
      l1 = [l0]
      l1[0][0] = 1
      l0 == [1] or raise

  # Contains any number of objects of any type.

    is = [0, 'a', 'abc']
    is[0] == 0 or raise
    is[1] == 'a' or raise

  # Also possible to create via explicit constructor:

    Array.new          == [] or raise
    Array.new(3)       == [nil, nil, nil] or raise
    Array.new(3, true) == [true, true, true] or raise

  # In Ruby, `[]` operator overload can have any number of arguments.
  # The following are jsut constructors:

    Array.[](1, 2) == [1, 2] or raise
    Array[1, 2]    == [1, 2] or raise

  ##Percent array string literal ##%w

    # Literal for an array of strings without spaces,
    # not interpolated and interpolated:

      %w( ab cd \n ) == ['ab', 'cd', '\n'] or raise
      %W( ab cd \n ) == ['ab', 'cd', "\n"] or raise
      %W( a#{'b'}c ) == ['abc'] or raise
      %W( a#{'b c'}d ) == ['ab cd'] or raise

  # From range:

    (0..2).to_a == [0, 1, 2] or raise
    Array(0..2) == [0, 1, 2] or raise

  # Length, size (alias):

    [0, 1, 2].length == 3 or raise
    [0, 1, 2].size   == 3 or raise

  # Last element:

    [0, 1].last == 1   or raise
    [0, 1][-1]  == 1   or raise
    [].last     == nil or raise
    [][-1]      == nil or raise

  ##slice

    # Slice: start, take how many:

      a = [0, 1, 2, 3]
      a[0, 2] == [0, 1] or raise
      a[0, 3] == [0, 1, 2] or raise
      a[1, 2] == [1, 2] or raise

    # Range select:

      (0..4).to_a[1..3]  == (1..3).to_a or raise
      (0..4).to_a[1..-2] == (1..3).to_a or raise
      (0..4).to_a[3..1]  == (3..1).to_a or raise
      (0..4).to_a[3..-3] == (3..2).to_a or raise
      (0..2).to_a[1..4]  == [1,2].to_a  or raise

    # Special cases: all but last:

      (0..4).to_a[0..-2]  == (0..3).to_a or raise

    # Insane special cases: for ranges, if the staring index is:
    #
    # - == length, return []
    # - != length and out of range, return nil
    #
    # TODO why such insane default? Probably because of requiring ranges to be lvalues.
    # <http://stackoverflow.com/questions/3568222/array-slicing-in-ruby-looking-for-explanation-for-illogical-behaviour-taken-fr?rq=1>

      [1][1..3] == []  or raise
      [1][2..3] == nil or raise

    # TODO why are the following not [1]??

      [1][0..-2] == [] or raise
      [1][0..-3] == [] or raise

    # But this one is (as expected):

      [1][0..-1] == [1] or raise

    # TODO: triple dots:

      #a[0...2]

  # Start from, take how many:

    (0..4).to_a[2, 2] == (2..3).to_a or raise
    (0..4).to_a[2, 0] == [] or raise

  # Unpack:

    i, j = [0, 1]
    i == 0 or raise
    j == 1 or raise

  # Array to string:

    ['ab', 'cd'].join(' ') == 'ab cd' or raise

  # Check if array contain element via include?:

    [0, 1].include?(0) or  raise
    [   1].include?(0) and raise

  # Note that this is different from String.include? which checks for substrings.

    ![0, 1].include?([0, 1]) or  raise

  ##Append ##<< ##push

    # Single element in-place:

      a = [0, 1]
      b = a << 2
      b[0] = -1
      a == [-1, 1, 2] or raise

    # Returns reference to the array:

      a = [1]
      b = a << 2
      b[0] = -1
      b == [-1, 2] or raise

    # Note how this differs from Strings, in which `<<` concatenates inplace! 

    # Same as push:

      a = [0, 1]
      b = a.push(2)
      b[0] = -1
      b == [-1, 1, 2] or raise

  ##Concatenate

    # Create new:

      a = [0, 1]
      (a + [2, 3]) == [0, 1, 2, 3] or raise
      a == [0, 1] or raise

    # After in-place:

      a = [0, 1]
      b = a.concat([2, 3])
      b[0] = -1
      a == [-1, 1, 2, 3] or raise

    # Same but less clean with `push(*`:

      a = [0, 1]
      b = a.push(*[2, 3])
      b[0] = -1
      a == [-1, 1, 2, 3] or raise

    # Before in-place with `unshift(*`:

      a = [0, 1]
      b = a.unshift(*[2, 3])
      b[0] = -1
      a == [-1, 3, 0, 1] or raise

    # Same but, less clean and more general with `insert(0, *`:

      a = [0, 1]
      b = a.insert(0, *[2, 3])
      b[0] = -1
      a == [-1, 3, 0, 1] or raise

  ##map method

    # Create a new array of modified elements:

      a = (0..2).to_a
      a.map { |x| x + 1 } == (1..3).to_a or raise
      a == (0..2).to_a or raise

    # In place version. Return the modified map itself:

      a = (0..2).to_a
      b = a.map! { |x| x + 1 }
      b == (1..3).to_a or raise
      a == (1..3).to_a or raise
      b[0] = 0
      a == [0, 2, 3] or raise

  ##collect

    # Alias to `map`.

  ##select ##filter ##reject ##delete_if

    # Python's filter is called select.

    # `delete_if` is the negation.

    # `reject` is like `delete_if` except it returns `nil` if no changes were made.

      ((0..3).to_a.select {|x| x % 2 == 0}) == [0, 2] or raise

  ##uniq

    # Remove duplicates:

      [0, 1, 0].uniq.sort == [0, 1] or raise

  ##sort_by

    # Sorts by block. Expects -1, 0 or 1.

      class Sort
        attr_accessor :i
        def initialize(i)
          @i = i
        end
        def ==(other)
          other.i == @i
        end
      end

      [Sort.new(2), Sort.new(0), Sort.new(1)].sort_by{|x| x.i}  == [Sort.new(0), Sort.new(1), Sort.new(2)] or raise
      [Sort.new(2), Sort.new(0), Sort.new(1)].sort_by(&:i)      == [Sort.new(0), Sort.new(1), Sort.new(2)] or raise
      [Sort.new(2), Sort.new(0), Sort.new(1)].sort_by{|x| -x.i} == [Sort.new(2), Sort.new(1), Sort.new(0)] or raise

  ##zip

    # Useful to iterate two arrays in parallel:

      [0, 1].zip([2, 3]) == [[0, 2], [1, 3]] or raise

      a = []
      [0, 1].zip([2, 3]).each do |x, y|
        a << [x, y]
      end
      a == [[0, 2], [1, 3]] or raise

  ##inject

    # Python reduce.

    # Without any argument, the first memo is set to the fist object, and the first obj is the second element:

      [1,2,3].reverse.inject{|memo, obj| memo = {obj => memo}} == {1=>{2=>3}} or raise

    # With an argument, the first memo is set to it, and the first obj is the first element:

      [[1,1],[2,4],[3,9]].inject({}){|memo, obj| memo[obj[0]] = obj[1]; memo} == {1=>1, 2=>4, 3=>9} or raise

  ##empty?

      ''.empty?       or raise
      not '  '.empty? or raise
      [].empty?       or raise
      not [0].empty?  or raise
      {}.empty?       or raise

    # Only present for collection like objects:

      begin
        0.empty?
      rescue NoMethodError
      else
        raise
      end

    # Rails adds `blank` which works on all objects.

##range ##.. ##...

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

  ##contained in

    # Contained test test with `===`:

      (1..3) === 2 or raise

    # Does not work between ranges:

      not (1..2) == (1..3) or raise

    # Does not work with `==`

      not (1..3) ==  2 or raise

    # Not reflexive:

      not 2 === (1..3) or raise

##hash ##map

    m = { 1 => 'one', 2 => 'two' }
    m[1] == 'one' or raise
    m[2] == 'two' or raise

  # It is possible to ommit the `{}` when inside a function call:

    def f(h)
      h[1]
    end

    f(1 => 'one', 2 => 'two') == 'one' or raise
    f 1 => 'one', 2 => 'two'  == 'one' or raise

  # A new shorthand syntax was added in 1.9 for hashes with symbol keys
  # because this is a very common use case:

    if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('1.9')
      m  = { :a => 1, :b => 2 }
      m2 = { a: 1, b: 2 }
      m == m2 or raise
    end

  # bbatsov says you should use it whenever possible.

  # From array:

    a = [0, 1, 2]
    Hash[a.collect{|v| [v, v*v]}] == { 0 => 0, 1 => 1, 2 => 4 }

  ##Hash foreach iteration

    # Iteration order: random in 1.8, same as literal in 1.9.

      m = { 2 => 'two', 1 => 'one'}
      keys = [2, 1]
      i = 0
      m.each do |k, v|
        if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('1.9')
          k == keys[i] or raise
        end
        m[k] == v or raise
        i += 1
      end

  ##Access missing key

    # Non existing keys simply return nil value, no exception:

      x = {a: 1}
      x[:b] == nil or raise

    # It is possible to change the global default via the explicit constructor:

      x = Hash.new(1)
      x[:a] == 1 or raise

    # Single call default with `fetch`.

  ##get ##fetch

    # Get val or return given default if not present.

      h = {a: 1, b: 2}
      h.fetch(:a, 3) == 1 or raise
      h.fetch(:d, 3) == 3 or raise

  ##merge

    # Like Python extend.

      {a: 0, b: 1}.merge({a: 10, c: 2}) == {a: 10, b: 1, c: 2} or raise

  ##delete

      h = {a:0, b:1}
      h.delete(:a) == 0 or raise
      h == {b:1} or raise

##Operators

  ##Logic

    ##! vs not

      # `not` has very low precedence.

        def f(b)
          b
        end

        f(!true) == false or raise

      # Syntax error TODO why? so it is not just a precedence question?:
      # `not` does not return any value?

        #f(not true)

        if not true
          raise
        end

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

  ##==

    # By the Object `==` compares by id, not fields:

      class Eq2
        attr_accessor :i
        def initialize(i)
          @i = i
        end
      end

      Eq2.new(0) != Eq2.new(0) or raise

  ##===

    # Used on case statements instead of `==`:

      class Eq3
        def initialize(i)
          @i = i
        end

        def ===(other)
          @i == other + 1
        end
      end

      case 0
      when Eq3.new(0)
        #Eq3.new(0) === 0
        raise
      when Eq3.new(1)
        #Eq3.new(0) === 1
      else
        raise
      end

    # For Object is the same as `==`, but certain stdlib classes override it,
    # notably: Regexp, Range and Proc to work well with `case` statements.

    # Generally speaking, `===` menas a less strict match than `==`.

      input = ['a0', 3, 0]
      output = []
      input.each do |x|
        case x
        when /a(.)/
          output << x
        when 2..4
          output << x
        when lambda {|x| x*x == 0 }
          output << x
        end
      end
      input == output or raise

    # Each case can take multiple values:

      a = false
      case 1
      when 0, 1
        a = true
      else
        raise
      end
      a or raise

  ##<=>

    # `a <=> b` returns:
    #
    # -  `0` if equal
    # -  `1` if `a > b`
    # - `-1` if `a < b`

      (0 <=>  1) == -1 or raise
      (0 <=>  0) ==  0 or raise
      (0 <=> -1) ==  1 or raise

  ##eq?

    # On Object same as `==`.

    # A few stdlib classes override it.

    # I prefer never to override this to avoid confusion.
    # Use a more explicit indication of the difference with `==`.

    # One of the classes that overrides it is Numeric, where it affects type conversion:

      1 == 1.0 or raise
      not 1.eql?(1.0) or raise

  ##equal?

    # Compare by ID.

    # Never overrided on stdlib base classes, and should never be in any sane lib.

      not 'abc'.equal?('abc') or raise
      :abc.equal?(:abc) or raise

  ##defined?

      not defined? not_yet_defined or raise
      a = 1
      defined? a or raise

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

    # While modifier multiple statements to do a do while:

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
        is.each {
          $is[$i] == $i or raise
          $i += 1
        }
        j == 2 or raise

      # If no loop variables will be needed, the `||` can be omitted:

        i = 0
        (1..3).each do
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
      (1..3).each do |i|
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
      3.times do |i|
        is[j] == i or raise
        j += 1
      end
      j == 3 or raise

##if ##elsif ##truthy ##falsy

  # Only `false` and `nil` are falsy.

    if false
      raise
    elsif true
    else
      raise
    end

    if nil
      raise
    else
    end

  # Even 0 is truthy:

    if 0
    else
      raise
    end

  ##unless

    # Exactly the same as `if not`.

    # I feel it is more used that `if not` by the ruby community,
    # including in https://github.com/bbatsov/ruby-style-guide.

    # Not recommended to be used with `else`, better to just inverse
    # the order of the statements.

    # No, there is no `elsunless`: http://stackoverflow.com/questions/20470308/why-is-there-no-elsunless-statement-in-ruby

    #a = 0
    #if false
      #raise
    #elsunless false
      #a = 1
    #else
      #raise
    #end
    #a == 1 or raise

##case ##switch

    case 0
    when 0
    when 1
      raise
    else
      raise
    end

  # Objects are evaluated according to the `===` operator and not the `==` operator!
  # See `===` for more info.

##method ##function

  # Syntax: http://www.ruby-doc.org/core-2.1.2/doc/syntax/methods_rdoc.html

  # Class:  http://www.ruby-doc.org/core-2.1.2/Method.html

  ##Return value

    # Like in Perl, is the value of the last statement.

  ##Multiple return values

      i, j = 1, 2
      i == 1 or raise
      j == 2 or raise

      i, j = 0, 0
      def f
        return 1, 2
      end
      i, j = f
      i == 1 or raise
      j == 2 or raise

    # TODO it appears to be a magic return syntax,
    # not an explicit data type like Python tuples:

      #1, 2

  ##Definition

  ##def

    # Parenthesis are not mandatory.

    # bbatsov says use them iff there are arguments.

      def f
        1
      end
      f == 1 or raise

      def f
        1
      end
      f == 1 or raise

      def f(i)
        i
      end
      f(1) == 1 or raise

      def f(i)
        i
      end
      f(1) == 1 or raise

      def f(i, j)
        i + j
      end
      f(1, 1) == 2 or raise

      def f(i = 1, j = 2)
        i + j
      end
      f == 3 or raise

    # The definition returns a symbol:

      def f; end == :f or raise

  ##Scope

    # Local variables are not looked for outside methods:
    # (no closures like in Javascript):

      a = 0
      def f
        begin
          a
        rescue NameError
        else
          raise
        end
      end
      f

    # Methods are different:

      def g
        0
      end

      def f
        g
      end

      f == 0 or raise

    # Multiple method defintions are overriden.

      def f
        0
      end

      f == 0 or raise

      def f
        1
      end

      f == 1 or raise

    # If a variable has the same name as a method,
    # the method becomes invisible unless you use self:

      class MethodScope
        def f
          0
        end

        def g
          f = 1
          f == 1 or raise
          self.f
        end
      end
      MethodScope.new.g == 0 or raise

    # Nested method defintions are not possible:
    # http://stackoverflow.com/questions/4864191/is-it-possible-to-have-methods-inside-methods
    # Nested definitions seem to work, but in fact they dynamically define the method for the class.
    # This leads to method redefinition warnings.

      class NestedMethod
        def f
          def g
            0
          end
          g
        end
      end
      begin
        NestedMethod.new.g == 0 or raise
      rescue NoMethodError
      else
        raise
      end
      NestedMethod.new.f == 0 or raise
      NestedMethod.new.g == 0 or raise

    ##Global variable

      # Is looked for outside of methods.

        $i = 1
        i = 2
        $i == 1 or raise

        $i = 1
        def f
          $i
        end
        f == 1 or raise

        $i = 1
        def f
          $i = 2
        end
        f
        $i == 2 or raise

        i = 1
        def f
          $i = 2
        end
        f
        i == 1 or raise

        i = 1
        def f
          i
        end
        begin
          f
        rescue NameError
        else
          raise
        end

  ##call

    # Parenthesis are optional if no ambiguity is created.

      def f(i, j)
        i + j
      end

      f(1, 1)  == 2 or raise
      (f 1, 1) == 2 or raise

    # Special characters used for literals such as `"` for strings
    # don't need to be separated from the function name in a call:

      def f i
       return i
      end

      f'abc' == 'abc' or raise
      f:abc  == :abc or raise

    # TODO why does this give a syntax error:

      #f{a: 1} == {a: 1} or raise
      f({a: 1}) == {a: 1} or raise

  ##Parenthesis omission ambiguity

    # Calls without parenthesis could lead to potential ambiguities.

    # Never use them.

    # Spaces can determine the call behvaiour in those case.

      def f(i=1)
        i
      end

      f-1 == f - 1 or raise

      f -1 == f(-1) or raise

  ##method method

    # Because calls can happen without parenthesis, it is not possible to refer to the
    # function directly. One must use the `method` method instead.

      def f
        0
      end

    # Get the return value:

      a = f
      a == 0 or raise

    # Get the function itself:

      a = 1
      a = method(:f)
      a.call == 0 or raise

  ##Allowed identifier characters

    # Besides the usual alphanumeric characters,
    # the last character of a method name can also be either a question mark `?`
    # bang `!` or equals sign `=`.

    # `?` and `!` have no semantic value, and their meaning is
    # fixed by convention only. `=` also has a slight sintaxical meaning.

    # ?: the method returns true or false. It queries the state of an object.

      $i = 0
      def zero?
        $i == 0
      end

      zero? or raise

    # !: this is the in-place version of a method.

      def inc
        $i + 1
      end

      def inc!
        $i += 1
      end

      $i = 0
      inc == 1
      $i == 0
      inc! == 1
      $i == 1

    # =: indicates a set method, specially to differenciate from the get method.

      class EqualSuffix
        def initialize(i)
          @int = i
        end
        def int
          @int
        end
        def int=(i)
          @int = i
        end
      end

      o = EqualSuffix.new(1)
      o.int == 1 or raise

      o.int=(2)
      o.int == 2 or raise

    # `=` gives the method a new possible shorthand setter syntax:

      o.int = 3
      o.int == 3 or raise

    # Also works for compound operations:

      o.int += 1
      o.int == 4 or raise

  ##Variable length argument list ##nargs ##varargs

    # `*args` becomes an `Array` object.

      def sum(i, *is)
        is.class == Array or raise
        total = i
        is.each do |i|
          total += i
        end
        total
      end

      sum(1, 2, 3) == 6 or raise

    # Can be in the middle:

      def sum(i, *is, j)
        is.class == Array or raise
        total = i + j
        is.each do |i|
          total += i
        end
        total
      end

      sum(1, 2, 3, 4) == 10 or raise

  ##Splat ##Unpack argument list

    # Can be used both on definition and call.

    # On defintion, means variable number of arguments:

      def f(i, *is)
        i == 0 or raise
        is == [1, 2] or raise
      end
      f(0, 1, 2)

    # On call transforms array into arguments:

      def f(i, j)
        i == 0 or raise
        j == 1 or raise
      end
      f(*[0, 1])

    # On call can be used in the middle and as many times as you want:

      def f(i, j, k, l, m, n)
        i == 0 or raise
        j == 1 or raise
        k == 2 or raise
        l == 3 or raise
        m == 4 or raise
        n == 5 or raise
      end
      f(0, *[1, 2], 3, *[4, 5])

    # Both call and def splats can be combined:

      def f(i, *is)
        i == 0 or raise
        is == [1, 2] or raise
      end
      f(*[0, 1, 2])

    ##Naked asterisk

      # You can also use the asterisk alone as a parameter.

      # It eats up inputs just like a named asterisk,
      # but the only way to access it is with `super` forwarding.

        def f(i, *)
          i
        end

        f(1) == 1 or raise
        f(1, 2, 3) == 1 or raise

  ##Default values ##Optional arguments

      def f(x, y=2)
        x + y
      end

      f(1)    == 3 or raise
      f(1, 3) == 4 or raise

  ##Keyword arguments ##Named parameters ##kwargs

    # http://www.ruby-doc.org/core-2.1.2/doc/syntax/methods_rdoc.html#label-Keyword+Arguments

      if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.0')
        def f(a: 1, b: 10)
          a + b
        end

        f           == 11 or raise
        f(a:  2)      == 12 or raise
        f(b: 20)      == 21 or raise
        f(a:2, b: 20) == 22 or raise
      end

    ##**

      # Pass options hash after keyword arguments:

        if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.0')
          def f(a: 1, **args)
            a + (args[:b] || 0)
          end

          f(a: 1)       == 1 or raise
          f(a: 1, b: 2) == 3 or raise
        end

      # Not possible as `options = {}`
      # becaues there can be no regular arguments after the keyword arguments.

    # Without default value:

      if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.1')
        def f(a:)
          a + 1
        end

        f(a:1) == 2 or raise
        begin
          f
        rescue ArgumentError
        else
          raise
        end
      end

    # Before that, similar syntax could be achieved however by passing a hash,
    # setting it to default options={}, omiting call braces, and using the hash
    # inside of the method:

      def f(options = {})
        if options != {}
          options[:a] + options[:b]
        else
          0
        end
      end

      f({a:1, b:2}) == 3 or raise
      f(a:1, b:2)   == 3 or raise
      f           == 0 or raise

  ##Overload

    # Function overload does not exist.

    # Every new method with the same name as an existing one simply creates
    # a completely new method and erases the previous.

      def f() 1 end
      def f(i) 2 end

    # ERROR: f takes one argument:

      #f

  ##lambda

    # Function without name.

    # Differences from Procs:
    #
    # - enforces correct number of arguments
    # - an explicit return statement does not stop caller (unlike Procs).

      l = lambda {|x| x + 1 }
      l.call(1) == 2 or raise

    if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('1.9')
      ##-> ##stabby lambda

        # Exact same as lambda, but new notation.

          l = ->(x) { x + 1 }
          l.call(1) == 2 or raise

        # Parenthesis is optional:

          l = -> x { x + 1 }
          l.call(1) == 2 or raise

          l = -> x { x + 1 }
          l.call(1) == 2 or raise
    end

  ##__method__ ##__callee__

    # Get the name of the current method:
    # http://stackoverflow.com/questions/199527/get-the-name-of-the-currently-executing-method-in-ruby
    # TODO difference?

      def method_var
        __method__  == :method_var or raise
      end
      method_var

      def callee_var
        __callee__  == :callee_var or raise
      end
      callee_var

  ##Method class

    # http://www.ruby-doc.org/core-2.1.2/Method.html

    ##source_location

      # Get the location on the source for a method definition.

        def f
        end

        puts 'source_location = ' + method(:f).source_location.to_s

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

  # Understand Ruby's class model:

  # - <http://viewsourcecode.org/why/hacking/seeingMetaclassesClearly.html>

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

  ##Class class

    # Classes are members of the Class class.

      class ClassNoBase; end
      ClassNoBase.class == Class or raise

    # Class inherits from Module

      Class.superclass == Module or raise

  # Define a class:

    class C

      ##constructor
      def initialize(i=1)
        ##define instance variable
        @member_i = i
      end

      def method

        # Call another method of the instance:

          method2 == 2 or raise
          self.method2 == 2 or raise

        # Access an ##instance variable:

          @member_i

        # ERROR: TODO why? It works for methods.

          #self.@member_i
      end

      def method2
        2
      end

    end

  # In Ruby, Classes are also (constant) objects. `new` is just a method of that object:

    c = C.new(1)
    c.method == 1 or raise

  # The constructor is private: TODO how to make other methods private?

    #c.initialize

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

        def i
          return @i
        end

        def i=(i)
          @i = i
        end
      end

    # For the getter, it works because of parenthesis omission:

      o = GetSet.new

      o.i == 1 or raise
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

  ##Redefine a class

    # It is possible to extend a class by adding new methods to an existing class
    # after its initial declaration.

      class AddMethod
        def m0
          0
        end
      end

      class AddMethod
        def m1
          1
        end
      end

      c = AddMethod.new
      c.m0 == 0 or raise
      c.m1 == 1 or raise

    # This make monkey patching extremly easy to do:

      class Object
        def monkey_patch
          0
        end
      end

      Object.new.monkey_patch == 0 or raise

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

    def C.method4
      return 4
    end

    C.method4 == 4 or raise # ERROR

  ##self

      class Self
        # Inside the class scope, self is the class.
        #
        self == Self or raise

        # Inside instance methods, self is the instance.
        #
        def f
          self.class == Self or raise

          # Self can be ommited for method calls.
          self.f2 == 2 or raise
          f2 == 2 or raise
        end

        def f2
          2
        end
      end

      Self.new.f

  ##class methods ##class variables ##static

      class ClassMethod

        # Instance variable for the class object.
        @class_i   = 1

        # TODO difference from above
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

        def initialize
          ClassMethod.class_method
          #class_method             #=> ERROR
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
      #c.class_method           #=> ERROR
      #c.class_i2                 #=> ERROR

      # attr_accessor for class variable:

        class AttrAccessorClassVariable
          @v = 1
          class << self
            attr_accessor :v
          end
        end
        AttrAccessorClassVariable.v == 1 or raise

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
        def base_method
          return 1
        end
      end

      class Derived < Base
        def derived_method
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
          def i
            return @i
          end
        end

        class Derived < Base
          def initialize(i)
            super(i)
          end
        end

        Derived.new(1).i == 1 or raise

      # Without parenthesis, automatically forwards all the arguments *insane!*

        class DerivedSuperNoParenthesis < Base
          def initialize(i)
            super
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

      # Get parent class.

        class Base
          def base_method
            return 1
          end
        end

        class Derived < Base
          def derived_method
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

      puts 'instance_methods = '
      puts ReflectionDerived.instance_methods(false).sort

    ##send

      # Inherited from object.

      # Call method by symbol.

      # Remeber that symbols can end in either `=`, `?` and `!` without quotes.

        class Send
          def add(a, b)
            a + b
          end

          def add=
            1
          end
        end

        Send.new.send(:add=) == 1 or raise

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

##Module

  # Modules work like namespaces.

  # Modules are classes themselves:

    module ModuleIsClass
    end
    ModuleIsClass.class == Module or raise

  # Modules are similar to classes execpt that:

  # - it is not possible to instantiate them
  # - it is possible to get a multiple inheritance effect by including many modules

    module M

      i = 1
      I = 2
      # Error:
      #M.i = 3
      #M.I = 3

      def M.f
        # Error:
        #I
        M::I
        self::I
        1
      end

      def self.f1
        1
      end

      class << self
        def f1_2
          1
        end
      end

      def f2
        2
      end

      class C
        def f
          1
        end
      end

    end

    M.f == 1 or raise
    M::f == 1 or raise

    M.f1 == 1 or raise
    M.f1_2 == 1 or raise

  # Inner methods are invisible:

    #M::f2 == 2 or raise
    #f2 == 2 or raise

  ##dot vs double colons

    # Dot `.` and two double colons `::` are the same except for constants,
    # in which case only the colon works:

      #M.i == 1 or raise
      #M.I == 1 or raise
      #M::i == 2 or raise
      M::I == 2 or raise
      # Warning: modifying already initialized constant.
      #M::I = 3

    # It is generaly better style to use only dot `.` for methods, sinc that makes it clearer
    # that it is a method and not a constant.

  # Classes are constant objects so:

    #M.C.new.f == 1 or raise
    M::C.new.f == 1 or raise

  # Error: cannot add variables to the module after its creation:

    #M.j = 1

  # Can add new functions to the module after its creation:

    module Extend
      def self.f0
        0
      end
    end

    module Extend
      def self.f1
        1
      end
    end

    def Extend::f2
      2
    end

    class Extend::C
      def self.f0
        0
      end
    end

    Extend.f0 == 0 or raise
    Extend.f1 == 1 or raise
    Extend.f2 == 2 or raise
    Extend::C.f0 == 0 or raise

  ##include

    # Make module functions into instance methods.

      module IncludeModule
        def f2
          2
        end

        def self.f3
          3
        end
      end

      class IncludeClass
        include IncludeModule
        def f1
          f2 == 2 or raise
          1
        end
      end

      IncludeClass.new.f1 == 1 or raise
      IncludeClass.new.f2 == 2 or raise

    # Public module methods are not exported:

      #IncludeClass.new.f3
      #IncludeClass.f3

  ##extend

    # Make module functions into class methods.

      class ExtendClass
        extend IncludeModule
      end

      ExtendClass.f2 == 2 or raise

    # ERROR: undefined

    # Also possible to extend via the `extend` method from the `Object` class:

      class ExtendClassMethod; end
      ExtendClassMethod.extend(IncludeModule)
      ExtendClassMethod.f2 == 2 or raise

  ##include and extend at the same time

    # The following common pattern exists.

    # It is done automatically by Rails `ActiveSupport::Concern` inclusion.

    # It is a bit implicit.

      module IncludeExtendModule
        def self.included(base)
            base.extend(ClassMethods)
        end

        def f1; 1; end

        module ClassMethods
          def f2; 2; end
        end
      end

      class IncludeExtendClass
        include IncludeExtendModule
      end
      IncludeExtendClass.new.f1 == 1 or raise
      IncludeExtendClass.f2     == 2 or raise

  ##nesting

    # Metadata o which module we are in.

      $a = nil
      module M1
        module M2
          module M3
            $a = Module.nesting
          end
        end
      end
      $a == [M1::M2::M3, M1::M2, M1] or raise

  module ModuleTest
    extend self

    def f
      @a ||= 0
      @a += 1
    end
  end

  ModuleTest.f == 1 or raise
  ModuleTest.f == 2 or raise

##block ##yield ##iterator ##do

  # yield calls the bock that has been passed to the function:

    def f
      # This calls the block:
      yield == 2 or raise
      yield == 2 or raise
    end

    i = 0
    f { # This is the block.
      i += 1

      # ERROR: cannot use return here.
      #return 2

      # This value will be returned.
      2
    }
    i == 2 or raise

  # Do version:

    i = 0
    f do
      i += 1
      #return 2 # ERROR
      2
    end
    i == 2 or raise

  # There seems to not be any semantical difference between the two of them,
  # except precedence and different usage convention:
  # <http://stackoverflow.com/questions/2122380/using-do-block-vs-brackets>

  ##Chaining syntax

    # Although ugly, it is possible to call a function
    # on the return of a function that takes a block.

      def f
        yield
      end

      f { 1 }.to_s     == '1' or raise
      f do 1; end.to_s == '1' or raise

  # Pass arguments to yield:

    def f(i, j)
      yield(i, j)
    end
    f(2, 3) { |i, j| i * j } == 6 or raise

  ##Scope

    # Unlike methods, blocks are closuers.

    # Therefore they can modify variables from the scope where they are defined.

    # Works because block:

      def f
        yield
      end

      i = 0
      f do
        i += 1
      end
      i == 1 or raise

    # As any closure, the variable has to be defined outside,
    # or else it is considired a local variable:

      f do
        not_yet_defined = 1
      end

      not defined? not_yet_defined or raise

    # Fails because function:

      def f(func)
        func == 2 or raise
      end

      i = 0
      def g
        # Cannot change the outter i from here!
        # This will create a local i.
        i += 1
      end
      i == 0 or raise

  ##block context

      @class_i   = -1
      @@class_i2 = -2

      class C

        @class_i   = 1
        @@class_i2 = 2

        def C.class_method_yield
          yield
        end

        def C.class_method
          return 1
        end

        def self.self_method_yield
          yield
        end

        def self.self_method
          return 1
        end

        def initialize
          @i = 0
        end

        def method_yield
          yield
        end

        def method
          return 1
        end
      end

      o = C.new
      o.method_yield do
        #method           #=> undefined
        @class_i   == -1 or raise
        @@class_i2 ==  2 or raise
        #class_method     #=> undefined
        #self_method      #=> undefined
      end

      C.class_method_yield do
        @class_i   == -1 or raise
        @@class_i2 ==  2 or raise
        #class_method     #=> undefined
        #self_method      #=> undefined
      end

      C.self_method_yield do
        @class_i   == -1 or raise
        @@class_i2 ==  2 or raise
        #class_method     #=> undefined
        #self_method      #=> undefined
      end

  ##Optional block

    # If `yield` is used in a function, it is mandatory to pass a block to the function,
    # or this yields a runtime error.

      def f
        yield
      end

    # The block is mandatory:

      begin
        f
      rescue LocalJumpError
      else
        raise
      end

    # The block may depend on a parameter:

      def f(has_block = false)
        if has_block
          yield
        else
          0
        end
      end

      f             == 0 or raise
      f(true) { 1 } == 1 or raise

    ##block_given?

      # Generally the best option.

        def f
          if block_given?
            return yield
          else
            return 0
          end
        end

        f       == 0 or raise
        f { 1 } == 1 or raise

  ##Forward a block

  ##Convert a proc to a block

    # Does not forward by default:

      def f
        g
      end

      def g
        yield
      end

      begin
        f { 1 }
      rescue LocalJumpError
      else
        raise
      end

    # TODO: what is the best way to forward and still allow both `f` and g` to receive a block as in:

      #f { 1 } == 1 or raise
      #g { 1 } == 1 or raise

    # The best I could find was:

      def f(&block)
        g { block.call }
      end

      def g(&block)
        block.call
      end

      f { 1 } == 1 or raise
      g { 1 } == 1 or raise

    # but this is ugly because it creates a new dummy block.

  ##Ampersand argument syntax ##&block

    # If the last argument starts with ampersand,
    # captures the block into a Proc so you can explicitly access it.

    # Any argument name is fine, but `block` is the conventional one.

      def f(&block)
        # The block is a proc.
        block.class == Proc or raise
        block.call
      end

      f { 1 } == 1 or raise

    # `yield` still works:

      def f(&block)
        block.call
        yield
      end

      f { 1 } == 1 or raise

    # The ampersand argument parameter must be the last one.

    # This excludes functions with multiple ampersand parameters.

    # `i` is the last:

      #def f(&code, i) end

    # `code2` is the last. `code` is not:

      #def f(&code, &code2) end

    ##Application: TODO

    ##Ampersand symbol syntax ##&:

      # Shorthand for creating a block that calls a method of it's input.

        class AmpersandBlock
          attr_accessor :i
          def initialize(i)
            @i = i
          end
        end

      # TODO use own class instead of Array

        a = [0, 1, 2]
        a2 = a.map { |x| AmpersandBlock.new(x) }
        a2.map(&:i) == a or raise

##proc

  # Short for procedure. Has corresponding class `Proc`.

  # Same as blocks, but passed explicitly as function arguments.

  # Explicit proc creation:

    def f(code)
      code.call == 2 or raise
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
      code.call == 2 or raise
      code2.call == 2 or raise
    end

    p = Proc.new do
      i += 1
      2
    end

    i = 0
    f(p, p)
    i == 2 or raise

  ##Return statement inside procs

    #http://stackoverflow.com/questions/17800629/unexpected-return-localjumperror

      g = Proc.new do
        return 1
      end

      def f(g)
        g.call
        2
      end

    #TODO
    #f(g) == 2 or raise

  ##proc vs block

    # Every block is a proc:

      def f(&code)
        code.class == Proc or raise
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

##special ##predefined variables

  # Very insane. Good list: <http://www.zenspider.com/Languages/Ruby/QuickRef.html#pre-defined-variables>

  # By default, most don't have readable names, but `require 'English'` remedies that.

  # Many more exist besides those here and are kept in the thematic section closes to their application.

  ##$0

    # Contains the name of this script.

      puts "$0 = #{$0}"

  ##Command line arguments ##ARGV

      puts('ARGV = ' + ARGV.join(', '))

    ##ARGF ##$<

      # Python fileinput.

      # - if ARGV empty, ARGF == stdin
      # - else, assume that all elements of ARGV are files, and read from them sequentialy.

        #input = ARGF.read

  ##Environment variables ##ENV

    # Environment variables.

    # Print all environment:

      ENV.each do |k,v|
        #puts("ENV[#{k}] = #{v}")
      end

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

  # TODO

##require and family

  ##require

    # Kernel.

    # ERROR: require does not look under current dir starting from 1.9.2.
    # Use `require_relative` for that.

      #require 'main2'

    ##$LOAD_PATH ##$:

      # require search path

        puts('require search path:')
        puts($LOAD_PATH)
        $LOAD_PATH == $: or raise

  ##RUBYLIB

    # append to require path from environment variable:

    # RUBYLIB:          Additional search path for Ruby programs ($SAFE must be 0).
    # DLN_LIBRARY_PATH: Search path for dynamically loaded modules.

  ##require_relative

    # Requires file `main2.rb`:

      require_relative('main2')

      begin
        require_relative('i_dont_exist')
      rescue LoadError
      else
        raise
      end

    # Non-const variables are not imported:

      begin
        main2_i
      rescue NameError
      else
        raise
      end

      Main2_const == 2 or raise

      main2_f == 2 or raise
      Main2.f == 2 or raise
      AnyName.f == 2 or raise

    # Requires of requires are also required:

      main3_f == 3 or raise

  ##load

    # Kernel.

    # Very similar to require relative. Vs:
    # <http://stackoverflow.com/questions/6051773/how-to-call-rake-tasks-that-are-defined-in-the-standard-rakefile-from-an-other-r>
    # <http://stackoverflow.com/questions/804297/when-to-use-require-load-or-autoload-in-ruby>

    # Vs require:

      a = 0
      A = 0
      load('load.rb')
      # warning: already initialized constant.
      a == 0 or raise
      A == 1 or raise

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

  ##eval

    # Kernel.

    # Run string

      a = 0
      eval('a = 1')
      a == 1 or raise

##Exception ##begin ##ensure

  # Basic example:

    ensured = false
    begin
      raise(NameError)
    rescue NameError
    else
      raise
    ensure
      ensured = true
    end
    ensured or raise

  ##rescue

    # Get the exception object with a (magic?) `ExceptionClass => exception_object` hash syntax:

      begin
        raise('msg')
      rescue RuntimeError => ex
        ex.message == 'msg' or raise
      else
        raise
      end

    # Same syntax for empty exception type:

      begin
        raise('msg')
      rescue => ex
        ex.message == 'msg' or raise
      else
        raise
      end

    # You can use multiple rescue statements:

      begin
        raise(TypeError)
      rescue NameError
        raise
      rescue
      else
        raise
      end

    # Empty rescue command rescues all descendants of StandardError,
    # but not other classes like Exceptions.

    # To rescue all exceptions, use `rescue Exception`.

      begin
        raise(Exception.new)
      rescue
        raise
      rescue Exception
      else
        raise
      end

    ##rescue shorthand forms

      # It is possible to have a `rescue` withtout `begin`.

      # Inline form: single statement only, much like inline `if`:

        raise(0) rescue
        raise rescue

      # Paired with `def`: catches anything inside the function:

        def raise_exc
          raise
        rescue
        end

        raise_exc

      # Rescue multiple types:

        begin
          raise(Exception.new)
        rescue Exception, StandardError => ex
        else
          raise
        end

        begin
          raise(StandardError.new)
        rescue Exception, StandardError => ex
        else
          raise
        end


  ##raise

    # http://www.ruby-doc.org/core-2.1.2/Kernel.html#method-i-raise

    # Three forms:

    # - `raise`: raise a `RuntimeError` with empty message
    # - `raise('string')`: raise a `RuntimeError` with given message
    # - `raise('string')`: raise a `RuntimeError` with given message

      begin
        raise('msg')
      rescue RuntimeError => ex
        ex.class == RuntimeError or raise
        ex.message == 'msg' or raise
      else
        raise
      end


    # If you try to raise anything else, you get a `TypeError`:

      begin
        begin
          raise(1)
        rescue TypeError
        else
          raise
        end
      end

  ##fail

    # Alias to `raise`.

  ##Empty begin end

    # Some people use that to replace parenthesis because they think it looks better.

    # TODO Behaves exactly like parenthesis?
    # <http://stackoverflow.com/questions/13279217/are-there-unintended-consequences-of-rubys-begin-end-without-rescue-use>

      a = begin
            0
          end
      a == 0 or raise

  ##Built-in exceptions

    # Used throughout the standard library and built-in classes.

    # Ruby docs recommend that libs inherit from either `StandardError` or `RuntimeError`,
    # once, and then inherit all other errors from that class, so that all error of the
    # libray can be caught with a single expression.

    ##Exception class

      # Base class of all exceptions.

    ##StandardError

      # http://www.ruby-doc.org/core-2.1.2/StandardError.html

      # Only this class and descendants are caught by an empty `rescue`.

      # Parent class: `Exception`.

    ##RuntimeError

      # Type of exception raised by `raise` and `raise('string')`.

      # Parent class: `StandardError`. Therefore exceptions raised with an empty `raise`
      # can be caught by an empty `rescue`.

    ##SystemExit

      # Raise by `System.exit`.

      # Indicates that the code wants to terminate the program.

      # Can be caught like any other exception, but magic for:
      #
      # - Ruby, since no stack trace is printed for it
      # - IRB, since it exists if that exception reaches the top level

    ##SystemStackError

      # Stack level too deep, often infinite recursion.

        begin
          def stack_overflow
            stack_overflow
          end
          stack_overflow
        rescue SystemStackError
        else
          raise
        end

##throw ##catch

  # Vs raise rescue:
  # <http://stackoverflow.com/questions/51021/what-is-the-difference-between-raising-exceptions-vs-throwing-exceptions-in-ruby>

##math

    Math.sqrt(9) == 3 or raise

##io

    puts('stdout')
    print("stdout\n")

  ##puts

    # Is also part of Kernel. It calls `to_s` on strings.

      s = [1, 2]
      puts('puts format:')
      puts("#{s}")
      puts(s)

    # I the input ends in newline, does not add a newline. Insanity.

      puts("puts one trailing newline\n")
      puts("puts two trailing newlines\n\n")

  ##p

    # Similar to put, but calls `inspect` on obejcts, which should contain
    # more complete and debug useful content.

    # This is what irb shows by default.

      p 'abc'
      # Shows `"abc"`

      puts 'abc'
      # Shows `abc` (without the quotes).

  ##stdout ##$stdout ##STDOUT

    # `$stdout` can be reassigned, so always use it to print for more flexibility.
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

    ##stderr

      STDERR.puts('stderr')
      $stderr.puts('stderr')

##File ##file IO

  # File and pathname operations.

  # Generate a temporaty file path for tests:

    file = Tempfile.new('abc')
    path = file.path
    file.unlink

  ##Read and write entire file at once

    # `File.read(path)` and `File.write(path)`, inherited from `IO`.
    # Convenience methods over `File.new.read` + `file.close`.

  ##Path operations

    ##join

        File.join('a', 'b', 'c') == 'a' + File::SEPARATOR + 'b' + File::SEPARATOR + 'c' or raise

    ##basename

        File.basename(File.join('a', 'b', 'c')) == 'c' or raise

    ##unlink ##delete

      # Delete file.

    ##exists

      # Do not confound with `exist?` which is only for directories!

        !File.exists?(path) or raise
        file = File.new(path, 'w')
        file.close
        File.exists?(path) or raise
        File.unlink(path)
        !File.exists?(path) or raise

  ##open ##write ##read ##write

    # Must use `'b'` if there will be non ASCII chars.

      data = 'abc'

      File.open(path, 'w') do |f|
        f.write(data)
      end
      File.read(path) == data or raise

    ##linewise

        data_read = ''
        file = File.new(path, 'r')
        while line = file.gets
            data_read += line
        end
        file.close
        data_read == data or raise

      File.unlink(path)

      File.open(path, 'w') do |f|
        f.write(data)
      end

##Dir

  ##List directory ##ls ##entries

      entries = Dir.entries('.')
      entries.include?('.') or raise
      entries.include?('..') or raise
      puts "Dir.entries('.') = " + entries.inspect

  ##rmdir

    # Remove empty directory. For non empty, consider `fileutils.rm_rf`.

      #Dir.rmdir('.')

  ##pwd

  ##getwd

    # Same.

      puts 'pwd =   ' + Dir.pwd
      puts 'getwd = ' + Dir.getwd

##Process

  ##exit

    # Exit program with given status.

    # Same as `System.exit`.

    # Inherited by Kernel.

    # Does not exit immediately, but rather raises `SystemExit`.
    # This exception can be caught like any other.

      begin
        Process.exit(0)
      rescue SystemExit
      else
        raise
      end

##External Processes

  # Good article with all options: <http://blog.bigbinary.com/2012/10/18/backtick-system-exec-in-ruby.html>

  # TD;DR:

  # - use `system *W()` whenever you can because it does not use shell expansion and is rather sane.
  # - if you need quick stdout and stderr, use ``. bbatsov says use `` instead of %X().
  # - use popen if you need full control.

  ##PID ##ID of current process ##$$

      puts "Process.pid = #{Process.pid}"
      puts "$$ = #{$$}"

  ##system

    # Kernel.

    # Replaces current process, thus ends the program when execution ends.

    # Call types:

    # Expand:

      #system('echo *')

    # Don't use a shell:

      #system(*%W(echo *))

    # In particular:

    # - don't expand stuff like `*`
    # - don't interpret stuff like || and &&

    # Return value: True on exit statut 0, False on not-zero, `nil` on problems (signals?).

    # STDIN, STDOUT and STDERR are bound to the current terminal, so you cannot get them out.

      system("ruby -e 'puts \"#system\"'")

  ##spawn

    # Similar to system but does not wait for child to terminate.

    # Parent must explicitly wait for it to terminate with `wait`:
    # otherwise zombie process are accumulated:
    # children are kept around so that the parent can read their exit status.

  ##fork

    # Analogous to POSIX fork. Not implemented on Windows.

  ##backticks

    # Short to write, but not the most flexible method.

      o = `ruby -e 'print 1'`
      o == '1' or raise

    # Captures only stdout, not stderr:

      o = `ruby -e '$stderr.puts 1'`
      o == '' or raise

    # Only one newline character is chomped from the end of the stdout,
    # unlike Bash's `` which chomps all trailling newlines.

      o = `ruby -e 'puts "a\n\n"'`
      o == "a\n\n" or raise

    ##exec

      # Kernel.

      # Replaces current process, thus ends the program when execution ends.

    ##$?

      # Contains an object with information about the last called and waited external command.

      # Set by ``.

      # Sets the `$?` variable.

        # puts $?.exitstatus

  ##%x(date)

    # Same as backticks percent style.

    # bbatsov says use backticks unless your command
    # contains backticks (which is unlikely).

      o = %x(ruby -e 'print 1')
      o == '1' or raise

  ##popen3

    # More general process IO.

  ##current user ##uid

      puts 'Process.euid = ' + Process.euid.to_s

##time date

  # Current time as ISO string (from year to second):

    puts 'Time.now = ' + Time.now.to_s

##Gem

  # Compare SemVer strings:

    Gem::Version.new('0.10.1') > Gem::Version.new('0.4.1') or raise

  # Handle Gemfile version range specification:

     Gem::Dependency.new('', '~> 1.4.5').match?('', '1.4.6beta4') or raise
    !Gem::Dependency.new('', '~> 1.5.5').match?('', '1.4.6beta4') or raise

##stdlib

  ##OpenStruct

    # Sintatically like a class that can add attributes on the fly.

    # Hash based, therefore potentially slower than Hash.

      require 'ostruct'

      s = OpenStruct.new
      s.a = 0
      s.b = 'a'

      s.a == 0   or raise
      s.b == 'a' or raise
      s.c == nil or raise

  ##StringIO

    # String that looks like a file to do IO tests.

      require 'stringio'
      file = StringIO.new
      file.write('a')
      file.flush
      # TODO how does it work?
      #file.read == "a" or raise
      file.close

  ##pp ##pretty print

    # Format Ruby objects nicely for human consumption.

      require 'pp'

      puts 'puts / pp'

      os = [
        [0, 1, 2],
        {a: 0, b: 1, c: 2}
      ]

      os.each do |o|
        puts(o)
        pp(o)
      end

  ##fileutils

    ##rm_rf

        require 'fileutils'
        #FileUtils.rm_rf(dir)

  ##Tempfile

      require 'tempfile'
      file = Tempfile.new('abc')
      # A unique filename in the OS's temp directory,
      # e.g.: "/tmp/abc.24722.0"
      # This filename contains 'abc' in its basename.
      puts "Tempfile.new('abc').path = " + file.path
      file.write('hello world')
      file.rewind
      file.read      # => "hello world"
      file.close
      file.unlink    # deletes the temp file

    # TODO how to generate only a temporary file name without creating it?

  ##Serialization

    # Two main methods:
    #
    # - Marshal.dump: binary. Faster.
    # - YAML::dump:   human readable.

      obj = {
        a: 0,
        b: '1',
        c: {a: 0}
      }

    ##YAML

        require('yaml')
        obj = [0, 1, {a: 2}]
        ser_obj = YAML::dump(obj)
        puts 'YAML::dump = ' + ser_obj
        obj == YAML::load(ser_obj) or raise

    ##Marshal

      # Name probably comes from: <https://en.wikipedia.org/wiki/Heraldry#Marshalling>
      #
      # In Ruby, it is a serialization algorithm, tht uses a binary format.
      #
      # Faster and smaller (TODO check) than YAML.
      #
      # In Java, serialization and Marshalling are different operations.
      #
      # In Python, the term is never used: there is only one type of serialization: `pickle`.

        obj = [0, 1, {a: 2}]
        ser_obj = Marshal.dump(obj)
        puts 'Marshal.dump = ' + ser_obj
        obj == Marshal.load(ser_obj) or raise

# Finalization:

  $stdout.flush
  $stderr.flush
  puts("ALL ASSERTS PASSED")
