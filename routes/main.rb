module CaptainADB
  class App < Sinatra::Base
    get '/' do
      redirect '/devices'
    end
  end
end