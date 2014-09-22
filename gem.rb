require 'rubygems'
si = Gem::SourceIndex.from_installed_gems
gems = si.find_name('rails')
gems.each { |gem| puts gem.version.version }
