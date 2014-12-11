require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    register Sinatra::Namespace
    include ADB
    
    namespace '/api' do
      post '/adb/action/restart/?' do
        restart_server
        return 202
      end
    end
    
    namespace '/' do
      get '/?' do
        redirect '/devices'
      end
    end
  end
end