module Subscribem
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    helper_method :current_account
    helper_method :current_user
    helper_method :user_signed_in?

    def current_account
      if user_signed_in?
        @current_account ||= env["warden"].user(:scope=>:account)
      end
    end

    def current_user
      if user_signed_in?
        @current_user ||= env["warden"].user(:scope => :user) 
      end
    end

    def user_signed_in?
      env["warden"].authenticated?(:user)
    end


    def authenticate_user!
      unless user_signed_in?
        flash[:notice] = "Please sign in."
        redirect_to "/sign_in"
      end
    end
  end
end
