class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_session, :current_user
  before_filter :start_session


  private
    
    def start_session #always start a session
      @user_session = UserSession.new
    end

    def check_codroo_owner 
      if (defined?(@current_user) &&  defined?(params[:id]))
        if !@current_user.codroos.exists?(params[:id])
          flash[:notice] = "You are not the owner"
          redirect_to codroos_path
          return false
        end
      else
        flash[:notice] = "Invalid request"
        redirect_to codroos_path
        return false
      end
    end

    def current_user_session #return UserSession object
      logger.debug "ApplicationController::current_user_session"
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find 
    end

    def current_user #return User object
      logger.debug "ApplicationController::current_user"
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user #deny access if not logged in
      logger.debug "ApplicationController::require_user"
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user #deny access if logged in
      logger.debug "ApplicationController::require_no_user"
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end

    def store_location #store current URI
     session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default) #function for performing a redirect
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

end

