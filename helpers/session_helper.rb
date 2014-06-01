require 'sinatra/base'

module Sinatra
  module SessionHelper
    def execute_if_session_variable_exists_else_show_flash(var_key, flash_type, msg, url, &blk)
      session_var = session[var_key]
      if session_var
        blk.call(session_var)
      else
        flash[flash_type] = msg
        redirect url
      end
    end
    
    def execute_if_package_name_exists_else_show_flash(&blk)
      var_key = :package_name
      flash_type = :error
      msg = 'Please specify application (package) name first.'
      url = '/'
      execute_if_session_variable_exists_else_show_flash(var_key, flash_type, msg, url, &blk)
    end
  end
end