module CaptainADB
  class App < Sinatra::Base
    get '/' do
      haml :main
    end
  end
end