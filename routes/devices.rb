require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    register Sinatra::Namespace
    include ADB
    
    namespace '/devices' do
      post '/?' do
        session[:device_sn] = params[:device_sn]
        redirect '/applications'
      end
      
      get '/?' do
        haml :devices, :locals => {:devices => list_devices_with_details}
      end
      
      get '.json' do
        content_type :json
        json list_devices_with_details
      end
      
      get '/:device_sn/packages.json' do |device_sn|
        json list_installed_packages(device_sn)
      end
    end
  end
end