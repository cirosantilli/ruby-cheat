#!/usr/bin/env ruby

require 'tempfile'

require 'capybara'
require 'capybara/poltergeist'

# false because very slow
TEST_SELENIUM = false

Capybara.app = Proc.new do |env|
  ['200', {'Content-Type' => 'text/html'}, [File.read('index.html')]]
end

def poltergeist(&block)
  current_driver(:poltergeist, block)
end

def selenium(&block)
  if TEST_SELENIUM
    current_driver(:selenium, block)
  end
end

def current_driver(driver, block)
  Capybara.current_driver = driver
  visit('/')
  block.call
  Capybara.use_default_driver
end

class CapybaraTest
  include Capybara::DSL

  def run

    ##DSL

      # You can either use class methods:

        Capybara.visit('/')

      # Or if you `include Capybara::DSL` you can write just:

        visit('/')

    ##Session

      # Class that contains most of the most useful methods!
      # <http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Session>

      # Delegates some methods to:
      # <http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Matchers>

      ##page

      ##curent_session

        # Same as the current session.

          page == Capybara.current_session or raise

        # All of its methods are brought in with the DSL, so never use this,
        # except for insane RSpec assertion syntax like `expect(page).to have...`,
        # where you need page and `to have` is magic.

          page.current_path == current_path or raise

      ##visit

      ##current_path

          visit('/')
          current_path == '/' or raise

          visit('/2')
          current_path == '/2' or raise

        # Only includes the path, **not** the query string!

          visit('/2?a=b')
          current_path == '/2' or raise

        # How to include the query string:
        # http://stackoverflow.com/questions/5228371/how-to-get-current-path-with-query-string-using-capybara
        # Best ways seems to be:

          visit('/2?a=b')
          URI.parse(current_url).request_uri == '/2?a=b' or raise
          current_url[current_host.size..-1] == '/2?a=b' or raise

        # Encoding:

          visit('/2?a%5Bb%5D=c')
          URI.parse(current_url).request_uri == '/2?a[b]=c' or raise

          visit('/2?a[b]=c')
          URI.parse(current_url).request_uri == '/2?a[b]=c' or raise

        # Click link was strict on invalid URLs where visit was not.
        # This may have changed as per <https://github.com/teampoltergeist/poltergeist/issues/349>

          #click_link('click-link-2-brace-id')
          #begin
            #URI.parse(current_url)
          #rescue URI::InvalidURIError
          #else
            #raise
          #end

          click_link('click-link-2-brace-encode-id')
          URI.parse(current_url).request_uri == '/2%5B' or raise

      ##current_url

        # Full current URL. Not very useful variable since uusally we do care about the domain.

          puts 'current_url = ' + current_url

        # The domain was `http://example.com`.

      ##current_host

          puts 'current_host = ' + current_host

      ##status_code

          visit('/')
          status_code == 200 or raise

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

      ##title

        # Content of the head title element:

          title == 'Capybara Cheat Title' or raise

      ##Finders

        # <http://www.rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Finders>

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

            # If true, only visible are found.

            # If false, **both** visible and invisible

            # Default: false.

            # Invisible means: TODO `visible:false`? `display:none`?
            # Seems to depend on Driver: on RackTest only uses `display:none` set on parent node.

            # Not very driver-portable.

              !all('#visible-empty',                 visible: true).empty? or raise
              !all('#visible-empty-background',      visible: true).empty? or raise
              !all('#visible-empty-background-same', visible: true).empty? or raise
              !all('#visible-visibility-hidden',     visible: true).empty? or raise
               all('#visible-display-none',          visible: true).empty? or raise

              poltergeist do
                !all('#visible-empty',                 visible: true).empty? or raise
                !all('#visible-empty-background',      visible: true).empty? or raise
                !all('#visible-empty-background-same', visible: true).empty? or raise
                !all('#visible-visibility-hidden',     visible: true).empty? or raise
                 all('#visible-display-none',          visible: true).empty? or raise
              end

              selenium do
                 all('#visible-empty',                 visible: true).empty? or raise
                !all('#visible-empty-background',      visible: true).empty? or raise
                !all('#visible-empty-background-same', visible: true).empty? or raise
                 all('#visible-visibility-hidden',     visible: true).empty? or raise
                 all('#visible-display-none',          visible: true).empty? or raise
              end

        ##find

          # `all(...)[0]`. Raise if none or multiple matches.

        ##find_link

          # `find('a', text: text)`

        ##find_by_id

          # `find("##{id}")

        ##find_field

          # `find(:field, ...)`

          # Finds any form control.

          ##disabled

            # Option enabled by the `:field` kind.

              !all(:field, 'disabled-false',    disabled: false).empty? or raise
               all(:field, 'disabled-false',    disabled: true ).empty? or raise
               all(:field, 'disabled-true',     disabled: false).empty? or raise
              !all(:field, 'disabled-true',     disabled: true ).empty? or raise
               all(:field, 'disabled-js-true',  disabled: true ).empty? or raise
               all(:field, 'disabled-js-false', disabled: false).empty? or raise

              poltergeist do
                !all(:field, 'disabled-false',    disabled: false).empty? or raise
                 all(:field, 'disabled-false',    disabled: true ).empty? or raise
                 all(:field, 'disabled-true',     disabled: false).empty? or raise
                !all(:field, 'disabled-true',     disabled: true ).empty? or raise
                !all(:field, 'disabled-js-true',  disabled: true ).empty? or raise
                !all(:field, 'disabled-js-false', disabled: false).empty? or raise
              end

          ##with

            # Find any type of input field: input text, textarea, checkboxes, etc.

            # `with`: the current (possibly Js modified) `.value` of the field.

              !all(:field, 'with',    with: 'a').empty? or raise
               all(:field, 'with',    with: 'b').empty? or raise
               all(:field, 'with-js', with: 'a').empty? or raise
               all(:field, 'with-js', with: 'b').empty? or raise

              poltergeist do
                !all(:field, 'with',    with: 'a').empty? or raise
                 all(:field, 'with',    with: 'b').empty? or raise
                 all(:field, 'with-js', with: 'a').empty? or raise
                !all(:field, 'with-js', with: 'b').empty? or raise
              end

        ##within

          # Limits scope of search to matching elements.

          # Useful to do multiple actions inside one scope.

            #within(:xpath, '//div[@id="delivery-address"]') do
              #fill_in('Street', :with => '12 Main Street')
            #end

          # For single inner searches, use multiple finds instead:

            #find('#id').find(:css, '.class')

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

            has_xpath?("//div[@id='xpath']//span") or raise
            has_xpath?("//div[@id='xpath']//span[@class='b']") or raise
            !has_xpath?("//div[@id='xpath']/span[@class='b']") or raise

          # Double or single quotes are the same:

            has_xpath?("//div[@id='xpath']") or raise
            has_xpath?('//div[@id="xpath"]') or raise

          ##* is an element of any type:

            has_xpath?("//*[@id='xpath']") or raise

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

      ##Matchers

      ##has methods

        # Useful for unit tests assertions with RSpec `expect`.

        # Convenience only as all are thin wrappers on top of finders.

          has_selector?('div') or raise
          has_no_selector?('asdf') or raise

        # Kind of useless since it golfs worse and is less readable than `!has`.

        ##has_selector?

          # !all(...).empty?

        ##has_xpath?

          # has_selector(:xpath, ...)

        ##has_css?

          # has_selector(:css, ...)

        ##has_content

          # Strips tags. Can also consider visibility with extra options.

            within('#has-content-tags') do
              has_content?('abc') or raise
              has_content?('ab') or raise
              !has_content?('ac') or raise
              !has_content?('A') or raise
              !has_content?('<i>') or raise
            end

          # Normalizes multiple whitespace to a single space:

            within('#has-content-spaces') do
              has_content?('a b c') or raise
            end

        ##has_text

          # Same as `has_content`.

        ##has_field

          # See `find_field`.

      ##User interaction

        # All methods here are convenience only.
        # The sanest way to achieve all those effects is to find the element with find,
        # and then use an Element method.

        ##click_link

          # Find `a` elements by either of:

          # - case sensitive innerHTML substring
          # - id

            visit('/')
            click_link('Click link 2')
            current_path == '/2' or raise

            visit('/')
            click_link('Click link 2')
            current_path == '/2' or raise

            visit('/')
            click_link('lick link 2')
            current_path == '/2' or raise

          # Id:

            visit('/')
            click_link('click-link-2-id')
            current_path == '/2' or raise

          # Case sensitive:

            begin
              click_link('click link 2')
            rescue Capybara::ElementNotFound
            else
              raise
            end

        ##click_button

          # Similar to `click_link`, but finds `button` and `input type="submit"` buttons.

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

    ##Javascript

      ##driver

        # Capybara is an unified interface to multiple drivers, which actually implement the functions.

        # Not all drivers support all functions. When this is the case, Capybara docs specify it.

        # Driver can be set under `support/env.rb`

          #Capybara.javascript_driver = :poltergeist

        # On Cucumber, drivers can be set per test with tags such as `@javascript`,
        # which uses the default Javascript enabled driver given by the `Capybara.javascript_driver` option.
        # There are also explicit `@selenium` and `@rack_test` tags.

        # List of supported drivers: <https://github.com/jnicklas/capybara#drivers>

        # - webkit: fastetst js capable

        ##RackTest

          # Capybara's default driver. Limited and very fast.

          # - only works with Rack apps like Rails or Sinatra,
          # - cannot access remote URLs.
          # - not CSS and Javascript aware: parses HTML with Nogokiri.

            !has_css?('#js-click-target', text: 'clicked') or raise
            find('#js-click').click
            !has_css?('#js-click-target', text: 'clicked') or raise

        ##Selenium

          # Most reproductible and slow since it actually opens browser windows (not headless).

            if TEST_SELENIUM
              Capybara.current_driver = :selenium
              # You MUST visit pages after changing the driver.
              visit('/')
              !has_css?('#js-click-target', text: 'clicked') or raise
              find('#js-click').click
              has_css?('#js-click-target', text: 'clicked') or raise
              Capybara.use_default_driver
            end

        ##webkit

          # Headless webkit therefore fast. Hard to install: gem installation compiles webkit.
          # <https://github.com/thoughtbot/capybara-webkit/releases>

        ##poltergeist

          # Integrates PhantomJS with Capybara:
          # <https://github.com/teampoltergeist/poltergeist>

          # PhantomJS is also webkit based, but lower level and more optimized to the web app testing task:
          # <http://stackoverflow.com/questions/23951381/how-do-poltergeist-phantomjs-and-capybara-webkit-differ>

          # This is probably the best option when testing Javascript features,
          # so Js features will be cheated under it.

            if true
              Capybara.current_driver = :poltergeist

              ##default_wait_time

                # When using a Js driver, every finder method keeps trying to find
                # for a given ammount of time.

                # This configures that timeout. Default: 2 seconds.

                  #Capybara.default_wait_time = 10

                ##Only Capybara finders get rerun

                  # Tests that use Capybara finders will wait:
                  # if you use stuff like `page.html.include?` Capybara will not wait.

                  # TODO can anything be done in that case?

                  ##wait_until

                    # There used to be `wait_until` but it was removed:
                    # http://www.elabs.se/blog/53-why-wait_until-was-removed-from-capybara

                  ##synchronize

                    # There is now `synchronize`, which gets re-run if a descentand of ElementNotFound gets raised:
                    # http://rubydoc.info/github/jnicklas/capybara/Capybara/Node/Base#synchronize-instance_method

              # Js works:

                visit('/')
                !has_css?('#js-click-target', text: 'clicked') or raise
                find('#js-click').click
                has_css?('#js-click-target', text: 'clicked') or raise

              ##execute_script

                # Run given Javascript on current page.

                  visit('/')
                  !has_css?('#js-click-target', text: 'clicked') or raise
                  execute_script("document.getElementById('js-click-target').innerHTML = 'clicked'")
                  has_css?('#js-click-target', text: 'clicked') or raise

                # Javascript errors generate Ruby exceptions by default:

                  begin
                    execute_script('not_defined;')
                  rescue
                  else
                    raise
                  end

                # Different Javascript errors generate different Ruby exceptions.
                # TODO how do they map exactly?

                # Errors can be avoided with an option.

                ##window.replace

                  # TODO can it work or not? <https://github.com/teampoltergeist/poltergeist/issues/220>

                    #visit('/')
                    #execute_script("window.location.replace('/2');")
                    #current_path == '/2' or raise

              ##evaluate_script

                # Can also get return values from Javascript.

                # TODO how is Js -> Ruby conversion done exactly?

                # Slower and more flexible. Only use if you need the return.

                  evaluate_script('1') == 1 or raise

              ##URL encoding

                # The behaviour is inconsistent with that of the RackTest driver!
                # This double encodes the URL.

                  visit('/2?a%5Bb%5D=c')
                  URI.parse(current_url).request_uri == '/2?a%255Bb%255D=c' or raise

              Capybara.use_default_driver
            end

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
