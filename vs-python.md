# Ruby vs Python

As of 2013, Ruby is almost equivalent to Python:

- main implementations are mostly interpreted (with some on the fly compiling)
- dynamically typed
- large cross-platform stdlib

It is a shame that the FOSS community must be divided over trivial differences.

Advantages of Python:

-   part of the LSB.

-   much more used. Ruby is only used because of RoR.

    Python is more useful in every other application domain.

-   Ruby uses many punctuation characters, often based on `sh` or `perl`,
    where using actual names would be saner.

    - `$:` for `require` path
    - `@`  for class instance variables
    - `?`, `!` and `=` allowed as method name suffixes

-   many convenience function which are too easily derivable from others.

    This means that programmers have to learn more language primitives:

    - `if` vs `unless`
    - `any?` vs `empty?`
    - `alias` is even a keyword to create more redundancy.
    - `not` vs `!`, only differentiated by precedence,
        so `!` which has lower precedence is more general
        (you can always add precedence with parenthesis, but not remove it)
    - `raise` vs `fail`
    - `Proc` vs methods: why have both? Complicates everything.

    If you are the poetic type, this comparison between programming languages
    and cars puts it beautifully <http://users.cms.caltech.edu/~mvanier/hacking/rants/cars.html>:

    > Ruby is a car that was formed when the Perl, Python and Smalltalk cars were involved in a three-way collision.
    > A Japanese mechanic found the pieces and put together a car which many drivers think is better than the sum of
    > the parts. Other drivers, however, grumble that a lot of the controls of the Ruby car have been duplicated or
    > triplicated, with some of the duplicate controls doing slightly different things in odd circumstances,
    > making the car harder to drive than it ought to be. A redesign is rumored to be in the works.

-   requires of requires are also required.

    It becomes very hard to find where a function comes from.

    If you have ever tried to hack a large project,
    you will know that Python explicit `import` make your job *much* easier.

-   identifier first letter case matters:

        i = 0
        i = 1
        I = 0
        I = 1 #warning

-   `super` without parenthesis is different from `super()` with parenthesis!

Disadvantages of Python:

-   confusing global functions in places where methods would be adequate: `len` vs `split`.

-   statements that could be functions such as `print` (corrected in Python 3), `del`, `in`, etc.

-   Ruby built-in types look more like objects than Python's.

-   Ruby have some important tools on its stdlib, including:

    - ERB: a ruby/HTML template language, much like PHP.
    - rake: a Makefile system.

    In Python, those tools are lacking a good implementation as of 2013.
