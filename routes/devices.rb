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
        @use_d3 = true
        @use_fotorama = true
        settings.screenshot_files = get_screenshots_files(settings.screenshot_dir)
        haml :devices
      end
      
      get '.json' do
        content_type :json
        devices = list_devices_with_details
        if devices.empty?
          session[:device_sn] = nil
          session[:package_name] = nil
        end
        json devices
      end
      
      get '/:device_sn/packages.json' do |device_sn|
        content_type :json
        json list_installed_packages(device_sn)
      end
      
      post '/:device_sn/screenshots' do |device_sn|
        content_type :json
        result = take_a_screenshot(settings.screenshot_dir, device_sn)
        settings.screenshot_files = get_screenshots_files(settings.screenshot_dir)
        result.first ? [201, result[1].to_json] : [500, result[1].to_json]
      end
    end
  end
end