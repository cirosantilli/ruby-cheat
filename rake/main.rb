#!/usr/bin/env ruby

require 'rake'

# How to call rake taks computationally.

# How to do it is severly underdocumented.

# Not only do you have to load all the right things,
# but you also have to get around rake's duplicate task prevention.

# http://stackoverflow.com/questions/3530/how-do-i-rake-tasks-within-a-ruby-script
# http://stackoverflow.com/questions/577944/how-to-run-rake-tasks-from-within-rake-tasks

# Furthermore, there is no way to get a return value from the task.

# Conclusion: don't do this. Instead, define a function,
# and then call it from both the rake task and your desired call point.

case 0
when 0
  # Runs task twice.
  rake = Rake::Application.new
  Rake.application = rake
  rake.init
  rake.load_rakefile
  task = rake[:programmatic]

  ##execute

    # Always runs task, but not dependencies.

      task.execute
      task.execute

  ##invoke

    # Run task only if not already invoked state, and dependencies.

  ##reenable

    # Unmark already invoked state. Does not touch dependencies.

      task.invoke
      task.reenable
      task.invoke

    # To reenable all prerequisites do:

      task.reenable
      task.all_prerequisite_tasks.each &:reenable
      task.invoke
when 1
  Rake.application.init
  Rake.application.load_rakefile
  Rake.application[:programmatic].invoke
  Rake.application[:programmatic].reenable
  Rake.application[:programmatic].invoke
when 2
  load('Rakefile')
  Rake::Task[:programmatic].invoke
  Rake::Task["build"].reenable
  Rake::Task[:programmatic].invoke
end
