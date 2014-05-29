require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    include ADB
    
    post '/application/?' do
      session[:package_name] = params[:package_name]
      redirect '/'
    end
    
    get '/application/uninstall/?' do
      if session[:package_name]
        uninstall_app(session[:package_name])
      else
        'Please specify application (package) name first.'
      end
    end

    get '/application/clear/?' do
      if session[:package_name]
        clear_app(session[:package_name])
      else
        'Please specify application (package) name first.'
      end
    end
  end
end