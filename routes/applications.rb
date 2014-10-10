require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    register Sinatra::Namespace
    include ADB
    include Sinatra::SessionHelper
    
    namespace '/api/applications' do
      post '/:package_name/?' do
        content_type :json
        json 'message' => 'Application successfully designated.', 'application' => params[:package_name]
      end
      
      post '/?' do
        session[:package_name] = params[:package_name]
        redirect '/'
      end
    end
    
    namespace '/applications' do
      get '/?' do
        @use_jquery_ui = true
        unless session[:device_sn].nil?
          @installed_packages = list_installed_packages(session[:device_sn])
        else
          @installed_packages = []
        end
        haml :applications
      end
    end
  end
end