require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    register Sinatra::Namespace
    include ADB
    
    namespace '/devices' do
      post '/?' do
        session[:device_sn] = params[:device_sn]
        redirect '/'
      end
      
      get '/?' do
        haml :list, :locals => {:devices => list_devices_with_details}
      end
      
      get '.json' do
        content_type :json
        json list_devices_with_details
      end
    end
  end
end