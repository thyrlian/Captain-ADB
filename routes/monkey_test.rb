require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    include ADB
    
    get '/test/monkey/start/?' do
      start_monkey_test(@package_name)
      'Monkey Test starts'
    end

    get '/test/monkey/stop/?' do
      stop_monkey_test
      'Monkey Test is stopped'
    end
  end
end