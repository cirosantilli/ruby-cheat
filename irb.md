# IRB

Interactive REPL interface: `irb`.

Repeat last command: `<up>`

## Persistent history

Enable persistent history:

<http://stackoverflow.com/questions/10465251/can-i-get-the-ruby-on-rails-console-to-remember-my-command-history-umm-better>:

<http://stackoverflow.com/questions/2065923/irb-history-not-working>

    printf "require 'irb/ext/save-history'
    IRB.conf[:SAVE_HISTORY] = 1000
    IRB.conf[:HISTORY_FILE] = \"#{ENV['HOME']}/.irb_history\"
    " >> ~/.irbrc

Note that RVM has a default `.irbrc` that does that for you automatically.

## Understanding the prompt

    irb(main):001:0>
    ^^^ ^^^^  ^^^ ^^
    1   2     3   45

1.  Tells you it's IRB!

2.  TODO

3.  Number of commands since you started the session.

4.  `end` depth level:

        irb(main):001:0> if true
        irb(main):002:1> if true
        irb(main):003:2> 0
        irb(main):004:2> end
        irb(main):005:1> end
        => 0

5.  If a statement needs closing.

    Quotes:

        irb(main):001:0> 'a
        irb(main):002:0' b'
        => "a\nb"

    In the middle of a statement: `*` appears;

        irb(main):001:0> 1 +
        irb(main):002:0* 1
        => 2

    When on the middle of a statement, you can cancel it with Ctrl+C.

## Underscore

`_` is automatically set to the result of the last prompt.

It is overridden even if explicitly defined.

    irb(main):001:0> 1
    => 1
    irb(main):002:0> _
    => 1
    irb(main):003:0> _ = 2
    => 2
    irb(main):004:0> 3
    => 3
    irb(main):005:0> _
    => 3

