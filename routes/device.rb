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
        json list_devices_with_details
      end
    end
  end
end