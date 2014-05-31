require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    include ADB
    include Sinatra::SessionHelper
    
    post '/application/?' do
      session[:package_name] = params[:package_name]
      redirect '/'
    end
    
    get '/application/uninstall/?' do
      execute_if_package_name_exists do |package_name|
        uninstall_app(package_name)
      end
    end

    get '/application/clear/?' do
      execute_if_package_name_exists do |package_name|
        clear_app(package_name)
      end
    end
  end
end