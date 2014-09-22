#!/usr/bin/env ruby

require 'tempfile'

require 'capybara'

Capybara.app = Proc.new do |env|
  ['200', {'Content-Type' => 'text/html'}, [File.read('index.html')]]
end

class CapybaraTest
  include Capybara::DSL

  def run

    ##DSL

      # You can either use class methods:

        Capybara.visit('/')

      # Or if you `include Capybara::DSL` you can write just:

        visit('/')

    ##driver

      # Capybara is an unified interface to multiple drivers, which actually implement the functions.

      # Not all drivers support all functions. When this is the case, Capybara docs specify it.

      # Driver can be set under `support/env.rb`

        #Capybara.javascript_driver = :poltergeist

      # On Cucumber, drivers can be set per test with tags such as `@javascript`,
      # which uses the default Javascript enabled driver given by the `Capybara.javascript_driver` option.
      # There are also explicit `@selenium` and `@rack_test` tags.

      # List of supported drivers: <https://github.com/jnicklas/capybara#drivers>

      ##RackTest

        # Capybara's default driver. Simple, limited and fast.
        #
        # - only works with Rack apps like Rails or Sinatra,
        # - and cannot access remote URLs.
        # - only considers HTML, not CSS and Javascript. Parses HTML with Nogokiri.

    ##Session

      # Class that contains most of the most useful methods!
      # <http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Session>

      ##visit

      ##current_path

          visit('/')
          current_path == ('/') or raise
          visit('/2')
          current_path == ('/2') or raise

      ##body

        # The raw response body:

          #puts body

      ##save_and_open_page

        # Save response body to a temporary file and open it in default browser.

        # Good way to understand why tests are failing when the body is long.

        # Requires the `launchy` gem.

        # Can only take the filename. Creates it on current directory.

        # TODO get it working with the `path`. Without the path works fine,
        # with it does not open it correctly.

          visit('/')
          #path = 'a.tmp.html'
          #save_and_open_page(path)
          #File.unlink(path)

      ##querying

        ##title

          # Content of the head title element:

            title == 'Capybara Cheat Title' or raise

        ##all

          # http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Finders#all-instance_method

          # Most general find method. All others are convenience on top of this.

          # Returns Capyabara::Result, which is an Enumerable containing [Elements](http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Element)

          # If given, the first argument specifyies the query type:

            #page.find(:xpath, '//div[contains(., "bar")]')
            #page.find(:css, '#foo.class')

          # If not, uses an option which defaults to `:css`. So always specify.
          # to prevent breaks.

            #page.find(:css, '#foo.class')

          # Options:

          ##text

            # Restricts matches to elements that contain string if string given,
            # or that match regexp if regexp given.

            # Possible in native xpath, but not CSS3, and this options makes up for it.

               !all('#all-text', text: 'a' ).empty? or raise
               !all('#all-text', text: 'ab').empty? or raise
               !all('#all-text', text: 'ef').empty? or raise

            # Does not see HTML tags, but does see text inside inner elements.

               all('#all-text', text: 'ab<i>cd</i>ef').empty? or raise
               !all('#all-text', text: 'cd').empty? or raise

            # There is not driver portable way of doing that:
            # http://stackoverflow.com/questions/15981820/capybara-should-have-html-content
            # The best driver dependent method seems to be `evaluate_script`.

            # Text node elements separated by HTML tags are seen as contiguous.

               !all('#all-text', text: 'abcdef').empty? or raise
               all('#all-text', text: 'abef').empty? or raise

            # The start and end of regexp matches corresponds to the cncatented string:

               !all('#all-text', text: /^a/).empty? or raise
               all('#all-text', text: /^b/).empty? or raise
               all('#all-text', text: /^e/).empty? or raise

            # Trailing and heading whitespaces are removed:

               !all('#all-text-whitespace', text: /^a$/).empty? or raise
               all('#all-text-whitespace', text: ' a ').empty? or raise

          ##visible

            # Not very portable. If true, only visible are found.

            # If false, **both** visible and invisible

            # Invisible means: TODO `visible:false`? `display:none`?
            # Seems to depend on Driver: on RackTest only uses `display:none` set on parent node.

            # Default: false.

        ##find

          # `all()[0]`. Raise if none or multiple matches.

        ##find_link

          # `find('a', text: text)`

        ##find_by_id

          # `find("##{id}")

        ##within

          # Limits scope of search to matching elements.

          # Useful to do multiple actions inside one scope.

            #within(:xpath, '//div[@id="delivery-address"]') do
              #fill_in('Street', :with => '12 Main Street')
            #end

          # For single inner searches, use multiple finds instead:

            #find('#id').find(:css, '.class')

        ##has methods

          ##has_content

            # Stripts tags. Can also consider visibility with extra options.

              has_content?('paragraph') or raise
              !has_content?('<p>') or raise

          ##has_selector

            !# all(...).empty?

          ##has_xpath

            # has_selector(:xpath, ...)

          ##has_css

            # has_selector(:css, ...)

        ##xpath

          # A standard to do queries in XML.

          # Has nothing specific to do with Capybara, but putting a small tutorial here.

          # Prefer CSS as more web developpers use it, is also sane and golfs better.

          ##vs css selectors

            # Advantages of xpath:

            # -  select by content.

            #    Does not matter for Capybara because all CSS finder methods
            #    have the `text:` option which allows that.

            # Advantages of CSS:

            # - select by class without hacks
            # - much more widely known
            # - golfs better

            # Therefore, CSS is probably a better idea

          ##/ is direct child, `//` is descendant:

            has_xpath?("//p[@id='xpath-p-id']//span") or raise
            has_xpath?("//p[@id='xpath-p-id']//span[@class='b']") or raise
            !has_xpath?("//p[@id='xpath-p-id']/span[@class='b']") or raise

          # Double or single quotes are the same:

            has_xpath?("//p[@id='xpath-p-id']") or raise
            has_xpath?('//p[@id="xpath-p-id"]') or raise

          ##* is an element of any type:

            has_xpath?("//*[@id='xpath-p-id']") or raise

          # Multiple predicates:

            has_xpath?("//div[@id='xpath-text' and text()='div']") or raise

          ##@

            # #@ab='cd' for property `ab`
            # #@*='cd'  for any property = `cd`
            # #[@ab]    any element with the property `ab`

          ##text() for first inner non tag content:

            has_xpath?("//div[@id='xpath-text' and text()='div']") or raise

          ##dot TODO what does the dot select? vs text()?

            # has_xpath?("//div[@id='xpath-text' and .='div<span>span</span>div2']") or raise

          ##contains()

            has_xpath?("//div[@id='xpath-contains' and contains(text(), 'bcd')]") or raise

          ##class

            # There does not seem to be a convenient method to select CSS classes via XPATH:
            # <http://stackoverflow.com/questions/1390568/how-to-match-attributes-that-contain-a-certain-string>

            # The best option seems to be:

              #//*[contains(concat(' ', normalize-space(@class), ' '), ' atag ')]

            # Or just use CSS.

      ##User interaction

        # All methods here are convenience only.
        # The sanest way to achieve all those effects is to find the element with find,
        # and then use an Element method.

        ##click_link

            visit('/')
            click_link('2')
            current_path == '/2' or raise

        ##check

        ##uncheck

          # Check or uncheck a checkbox.

        ##fill_in

          # Find by id, name or label text and set the content.

            #page.fill_in 'Name', :with => 'Bob'

    ##Result

      # Conatins Elements. Implements `Enumerable`.

      # http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Result

    ##Element

      # http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Element

      # Capybara's representation of HTML elements, used by all of Capybara's methods,
      # returned inside the enumerable Capybara::Result for methods that return
      # multiple elements.

      # Useful methods:

      # - find: find inside element
      # - []: get value of attribute
      # - click: click on element
      # - set: set the text of input fields like `input` or `textarea`
      # - double_click:
      # - hover:
      # - visible? Not all drivers support CSS, so the result may be inaccurate.

    ##javascript

      ##Modal ##alert ##Popup

        # Not Driver portable.

        # Poltergeist: always confirms popups, not yet possible to dismiss:
        # <https://github.com/jonleighton/poltergeist/issues/80>

        # Selenium interface:

          #page.driver.browser.switch_to.alert.accept
          #page.driver.browser.switch_to.alert.dismiss
          #page.driver.browser.switch_to.alert.text
  end
end

CapybaraTest.new.run
