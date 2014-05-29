require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    include ADB
    
    get '/test/monkey/start/?' do
      if session[:package_name]
        start_monkey_test(session[:package_name])
        'Monkey Test starts'
      else
        'Please specify application (package) name first.'
      end
    end

    get '/test/monkey/stop/?' do
      stop_monkey_test
      'Monkey Test is stopped'
    end
  end
end