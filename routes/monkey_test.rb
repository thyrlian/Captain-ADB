require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    include ADB
    include Sinatra::SessionHelper
    
    get '/test/monkey/start/?' do
      execute_if_package_name_exists_else_show_flash do |package_name|
        start_monkey_test(package_name)
        'Monkey Test starts'
      end
    end

    get '/test/monkey/stop/?' do
      stop_monkey_test
      'Monkey Test is stopped'
    end
  end
end