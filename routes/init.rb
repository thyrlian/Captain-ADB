excl = ['import', 'init']
Dir["#{File.dirname(__FILE__)}/*.rb"].each { |file| require file unless excl.include?(/.*\/(.*?)\.rb$/.match(file)[1]) }