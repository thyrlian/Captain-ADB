require 'sinatra/base'

module Sinatra
  module SessionHelper
    def execute_if_session_variable_exists(var_key, msg, &blk)
      session_var = session[var_key]
      if session_var
        blk.call(session_var)
      else
        msg
      end
    end
    
    def execute_if_package_name_exists(&blk)
      execute_if_session_variable_exists(:package_name, 'Please specify application (package) name first.', &blk)
    end
  end
end