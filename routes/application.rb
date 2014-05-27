require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    include ADB
    
    get '/application/uninstall/?' do
      uninstall_app(@package_name)
    end

    get '/application/clear/?' do
      clear_app(@package_name)
    end
  end
end