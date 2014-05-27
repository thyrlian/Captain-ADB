require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    include ADB
    
    get '/devices/?' do
      haml :list, :locals => {:devices => list_devices}
    end
  end
end