module Merb
  module GlobalHelpers
    
    def current_user
      @_current_user ||= User.get(session[:user])
    end
    
  end
end
