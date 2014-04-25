Embedded Ruby. Ruby inside HTML, much like PHP does by default.

Part of the Ruby stdlib.

Both a Ruby API and an executable.

# Usage

Executable:

    echo '<% a = 1; b = 2 %>a = <%= a %>, b = <%= b %><%# comment %>' | erb

Output:

    a = 1, b = 2

API:

    require 'erb'
    input = "<% a = 1; b = 2 %>a = <%= a %>, b = <%= b %><%# comment %>"
    renderer = ERB.new(input)
    renderer.result() == 'a = 1, b = 2' or raise

# Tags

Alternatives:

    <% if false %>if
    <% else if false  %>else if
    <% else %>else
    <% end %>

produces `else`.

Loops:

    <% (1..3).times do %><%= n %> <% end %>

Produces: `1 2 3 `.
