module CaptainADB
  class App < Sinatra::Base
    get '/' do
      'Captain ADB'
    end
  end
end