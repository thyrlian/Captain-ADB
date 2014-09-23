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
      
      post '/:device_sn/screenshots' do |device_sn|
        file_path = take_a_screenshot("#{settings.public_folder}/img/screenshots", device_sn)
        file_path.respond_to?(:keys) ? [500, file_path.to_json] : [201, file_path]
      end
    end
  end
end