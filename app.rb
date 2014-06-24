require 'sinatra/base'
require 'sinatra/contrib'
require 'haml'
require 'rack-flash'

require_relative 'routes/init'
require_relative 'helpers/init'

module CaptainADB
  class App < Sinatra::Base
    configure do
      root_dir = File.dirname(__FILE__)
      set :root, root_dir
      set :app_file, File.join(root_dir, File.basename(__FILE__))
      set :views, "#{root_dir}/views"
      set :public_folder, "#{root_dir}/public"
      enable :sessions
      register Sinatra::Namespace
      use Rack::Flash
    end
  end
end