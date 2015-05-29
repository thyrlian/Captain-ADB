require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    register Sinatra::Namespace
    include ADB
    
    namespace '/test/monkey' do
      get '/start/?' do
        package_name = session[:package_name]
        if package_name
          start_monkey_test(package_name)
          'Monkey Test starts'
        else
          return 404
        end
      end

      get '/stop/?' do
        stop_monkey_test
        'Monkey Test is stopped'
      end
    end
  end
end