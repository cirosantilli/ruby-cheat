# Ruby Implementations

Ruby has a few major implementations.

List of the major ones: <https://www.ruby-lang.org/en/about/>

## MRI

Matt's ruby, after the original creator of the language.

Reference implementation. Coded in C.

## MRuby

Lightweight embeddable version: <https://github.com/mruby/mruby>

Also by Matz.

Can be easily called from C.

Part of the core language and stdlib are not present,
some of it is offered as optional components called mrbgems:
<http://stackoverflow.com/questions/18732828/what-are-the-major-omissions-in-mruby-compared-to-mri>

## JRuby

Runs on top of JVM: compiles Ruby to Java object code.

## IronRuby

.Net VM.

## Cardinal

Perl VM!

## Rubinius

Seems to use LLVM JIT compilation.
