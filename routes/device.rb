require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    register Sinatra::Namespace
    include ADB
    
    namespace '/devices' do
      get '/?' do
        haml :list, :locals => {:devices => list_devices_with_details}
      end
      
      get '.json' do
        content_type :json
        devices = list_devices.inject([]) do |list, device|
          list.push({'sn' => device[0], 'type' => device[1]})
        end
        json devices
      end
    end
  end
end