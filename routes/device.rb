require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    register Sinatra::Namespace
    include ADB
    
    namespace '/devices' do
      get '/?' do
        haml :list, :locals => {:devices => list_devices}
      end
    end
  end
end