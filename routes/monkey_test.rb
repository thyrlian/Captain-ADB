require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    register Sinatra::Namespace
    include ADB
    include Sinatra::SessionHelper
    
    namespace '/test/monkey' do
      get '/start/?' do
        execute_if_package_name_exists_else_show_flash do |package_name|
          start_monkey_test(package_name)
          'Monkey Test starts'
        end
      end

      get '/stop/?' do
        stop_monkey_test
        'Monkey Test is stopped'
      end
    end
  end
end