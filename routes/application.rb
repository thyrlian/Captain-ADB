require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    register Sinatra::Namespace
    include ADB
    include Sinatra::SessionHelper
    
    namespace '/application' do
      post '/?' do
        session[:package_name] = params[:package_name]
        redirect '/'
      end
    
      get '/uninstall/?' do
        execute_if_package_name_exists_else_show_flash do |package_name|
          uninstall_app(package_name)
        end
      end

      get '/clear/?' do
        execute_if_package_name_exists_else_show_flash do |package_name|
          clear_app(package_name)
        end
      end
      
      post '/:package_name/?' do
        content_type :json
        session[:package_name] = params[:package_name]
        json 'message' => 'Application successfully designated.', 'application' => params[:package_name]
      end
      
      delete '/:package_name/?' do
        content_type :json
        json 'message' => uninstall_app(params[:package_name]), 'application' => params[:package_name]
      end
    end
  end
end