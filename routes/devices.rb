require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    register Sinatra::Namespace
    include ADB
    include FileHelper
    
    namespace '/devices' do
      post '/?' do
        session[:device_sn] = params[:device_sn]
        redirect '/applications'
      end
      
      get '/?' do
        @use_fotorama = true
        session[:screenshots] = get_screenshots_files("#{settings.public_folder}/img/screenshots")
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
        dir = "#{settings.public_folder}/img/screenshots"
        result = take_a_screenshot(dir, device_sn)
        session[:screenshots] = get_screenshots_files(dir)
        result.first ? [201, result[1].to_json] : [500, result[1].to_json]
      end
    end
  end
end