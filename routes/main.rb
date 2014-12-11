require_relative 'import'

module CaptainADB
  class App < Sinatra::Base
    register Sinatra::Namespace
    include ADB
    
    namespace '/api' do
      post '/adb/action/restart/?' do
        content_type :json
        result = restart_server
        result.first ? [200, result[1].to_json] : [500, result[1].to_json]
      end
    end
    
    namespace '/' do
      get '/?' do
        redirect '/devices'
      end
    end
  end
end